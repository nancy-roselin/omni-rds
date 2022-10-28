terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

data "aws_availability_zones" "available" {}

resource "aws_subnet" "subnet" {
  count                   = length(var.subnet_ids) >= var.az_count ? 0 : var.az_count
  cidr_block              = cidrsubnet(var.cidr_block, 4, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available)]
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name        = "${var.name}-${var.subnet_type[var.map_public_ip_on_launch]}-subnet-${data.aws_availability_zones.available.names[count.index]}"
    Environment = var.name
  }
}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
  depends_on = [
    aws_subnet.subnet
  ]
}
data "aws_subnet" "subnet" {
  for_each = var.subnet_ids == "" ? toset([]) : toset(data.aws_subnets.subnets.ids)
  id       = each.value
  depends_on = [
    aws_subnet.subnet,
    data.aws_subnets.subnets
  ]
}
