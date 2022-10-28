output "vpc_id" {
  value = var.vpc_id == "" ? aws_vpc.vpc[0].id : var.vpc_id
}

output "vpc_cidr_block" {
  value = data.aws_vpc.vpc.cidr_block
}

output "main_route_table_id" {
  value = data.aws_vpc.vpc.main_route_table_id
}
