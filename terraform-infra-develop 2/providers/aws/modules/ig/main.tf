# Internet Gateway for the public subnet
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_internet_gateway" "gw" {
  count  = var.vpc_specific_id != "" ? 0 : 1
  vpc_id = var.vpc_id

  tags = {
    Name        = "${var.name}-igw"
    Environment = var.name
  }
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  count                  = var.vpc_specific_id != "" ? 0 : 1
  route_table_id         = var.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw[0].id
}

# Create a NAT gateway with an EIP for each private subnet to get internet connectivity
resource "aws_eip" "gw" {
  count      = var.vpc_specific_id != "" ? 0 : 1
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "gw" {
  count         = var.vpc_specific_id != "" ? 0 : 1
  subnet_id     = var.subnet_id_public
  allocation_id = aws_eip.gw[0].id

  tags = {
    Name        = "${var.name}-nat"
    Environment = var.name
  }
}

# Create a new route table for the private subnets
# And make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  count  = var.vpc_specific_id != "" ? 0 : 1
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw[0].id
  }
}

# Explicitely associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = var.vpc_specific_id != "" ? 0 : 1
  subnet_id      = var.subnet_id_private
  route_table_id = var.main_route_table_id
}

resource "aws_route_table_association" "public" {
  count          = var.vpc_specific_id != "" ? 0 : 1
  subnet_id      = var.subnet_id_public
  route_table_id = var.main_route_table_id
}
