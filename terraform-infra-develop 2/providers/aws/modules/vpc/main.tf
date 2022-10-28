terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_vpc" "vpc" {
  count                = var.vpc_id != "" ? 0 : 1
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.name}-vpc"
    Environment = var.name
  }
}

data "aws_vpc" "vpc" {
  id = var.vpc_id == "" ? aws_vpc.vpc[0].id : var.vpc_id
  depends_on = [
    aws_vpc.vpc
  ]
}
