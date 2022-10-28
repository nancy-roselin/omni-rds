terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {
  tags = {
    Name        = "${var.name}"
    Creator     = "Terraform"
    Environment = var.name
  }
}

######### If need use prepared AMI ####
# data "aws_ami" "latest" {
#   most_recent = true
#   owners      = ["self"]

#   filter {
#     name   = "name"
#     values = [var.instance_ami]
#   }
# }
######### 

# Choise the VPC
data "aws_vpc" "this" {
  id = var.vpc_specific_id == "" ? var.vpc_id : var.vpc_specific_id
}

# Choise the subnets
data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_availability_zones" "available" {}

data "aws_iam_policy" "amazonssm" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

data "aws_route53_zone" "hosted-zone" {
  name = var.domain
}

resource "aws_instance" "webserver" {
  # ami                         = data.aws_ami.latest.id  #### for preinstaled AMI
  ami                         = var.instance_ami
  associate_public_ip_address = var.associate_public_ip_address
  count                       = var.instance_count
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = var.vpc_security_group_id
  availability_zone           = data.aws_availability_zones.available.names[0]
  iam_instance_profile        = aws_iam_instance_profile.setup_profile.name
  tags                        = local.tags
  subnet_id                   = var.subnet_id
  root_block_device {
    volume_type           = var.volume_type
    volume_size           = var.volume_size
    delete_on_termination = true
  }
}

resource "aws_iam_instance_profile" "setup_profile" {
  name_prefix = "${var.subdomain_name}-${var.name}-"
  role        = aws_iam_role.setup_role.name
}

resource "aws_iam_role" "setup_role" {
  name_prefix         = "${var.subdomain_name}-${var.name}-"
  managed_policy_arns = [data.aws_iam_policy.amazonssm.arn]
  path                = "/"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


