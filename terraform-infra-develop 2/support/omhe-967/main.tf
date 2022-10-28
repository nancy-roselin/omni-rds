// Manage the application infrastructure

// Require a specific version of terraform to help
provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 1.1.2"

  required_providers {
    aws = ">= 4.4"
  }
}

locals {
  ingress_rules_db = [{ port = "3306", cidr_blocks = [var.vpc_cidr_block], description = "Allow MySQL connections from VPC" }]

  sg_ingress_rules = {
    db = local.ingress_rules_db
  }
}


module "sgp" {
  for_each = local.sg_ingress_rules

  source        = "../../providers/aws/modules/sg"
  name          = var.environment
  vpc_id        = var.vpc_id
  ingress_rules = local.ingress_rules_db
  tags = {
    Name        = "${var.environment}-SG"
    Environment = var.environment
  }
  
}

module "rds_db_mysql" {
  source                 = "../../providers/aws/modules/rds_db_mysql"
  environment            = var.environment
  vpc_id                 = var.vpc_id
  cidr_blocks            = var.vpc_cidr_block
  private_subnet_ids     = var.private_subnet_ids
  create_random_password = var.db_mysql_instance_create_random_password
  identifier             = var.db_mysql_identifier
  instance_class         = var.db_mysql_instance_class
  allocated_storage      = var.db_mysql_instance_allocated_storage
  storage_encrypted      = var.db_mysql_storage_encrypted
  engine                 = var.db_mysql_instance_engine
  engine_version         = var.db_mysql_instance_engine_version
  db_name                = var.db_mysql_name
  username               = var.db_mysql_instance_username
  publicly_accessible    = var.db_mysql_instance_publicly_accessible
  skip_final_snapshot    = var.db_mysql_instance_skip_final_snapshot
  subnets_prefix_name    = var.db_mysql_subnets_prefix_name
  deletion_protection    = var.db_mysql_deletion_protection
  vpc_security_group_ids = [module.sgp["db"].sgid]
}