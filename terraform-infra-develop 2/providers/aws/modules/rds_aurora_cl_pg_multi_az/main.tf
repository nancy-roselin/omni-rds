terraform {
  required_version = ">= 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

locals {
  master_password = var.create_random_password ? random_password.master_password[0].result : var.master_password
}

resource "random_password" "master_password" {
  count = var.create_random_password ? 1 : 0

  length = 16
  # Some special characters are not supported
  special = false
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/${var.environment}/database/postgresql-password"
  description = "Passord for PostgreSQL"
  type        = "SecureString"
  value       = random_password.master_password[0].result

  tags = {
    environment = var.environment
  }
}

data "aws_ssm_parameter" "postgresql-password" {
  name = "/${var.environment}/database/postgresql-password"
  depends_on = [
    random_password.master_password,
    aws_ssm_parameter.db_password
  ]
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/${var.environment}/database/postgresql-username"
  description = "RDS database master username"
  type        = "String"
  value       = var.master_username

  tags = {
    environment = var.environment
  }
}

resource "aws_subnet" "this" {
  count = length(var.rds_subnets)

  availability_zone       = var.availability_zones[count.index]
  vpc_id                  = var.vpc_id
  cidr_block              = var.rds_subnets[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.cluster_name}-rds-${var.availability_zones[count.index]}"
  }
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.cluster_name}-${var.environment}-subnet_gr"
  subnet_ids = aws_subnet.this.*.id
  tags = {
    Name = "PostgreSQL subnet group"
  }
}

# Cluster parameter group
resource "aws_rds_cluster_parameter_group" "this" {
  name        = "${var.cluster_name}-${var.environment}-cluster"
  description = "Custom parameter group for cluster ${var.cluster_name}"
  family      = var.parameter_group_family

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }

  lifecycle { create_before_destroy = true }
}

data "aws_ssm_parameter" "db-password" {
  name = "/${var.environment}/database/postgresql-password"
  depends_on = [
    aws_ssm_parameter.db_password
  ]
}

resource "aws_security_group" "db" {
  name   = "${var.environment}-db-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "PgSQL access"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.ip_range]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_rds_cluster" "postgresql" {
  count = var.instance_count

  cluster_identifier      = "${var.cluster_name}-${count.index + 1}-${var.environment}"
  engine                  = "aurora-postgresql"
  engine_version          = var.engine_version
  availability_zones      = var.availability_zones
  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = data.aws_ssm_parameter.db-password.value
  backup_retention_period = 1
  preferred_backup_window = "07:00-08:00"
  vpc_security_group_ids  = [aws_security_group.db.id]
  apply_immediately       = var.apply_immediately
  skip_final_snapshot     = var.skip_final_snapshot
  db_subnet_group_name    = aws_db_subnet_group.this.name

  lifecycle {
    ignore_changes = [availability_zones]
  }
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count                = 1
  publicly_accessible  = false
  identifier           = "${var.cluster_name}-${count.index}"
  cluster_identifier   = aws_rds_cluster.postgresql[0].id
  instance_class       = var.instance_class
  engine               = aws_rds_cluster.postgresql[0].engine
  engine_version       = aws_rds_cluster.postgresql[0].engine_version
  db_subnet_group_name = aws_db_subnet_group.this.name
}
