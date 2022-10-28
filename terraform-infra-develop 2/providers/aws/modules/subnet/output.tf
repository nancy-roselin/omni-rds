output "public_subnets" {
  value = var.subnet_ids == "" ? aws_subnet.subnet.*.id : [for k, v in data.aws_subnet.subnet : v.id if v.map_public_ip_on_launch == true]
}

output "private_subnets" {
  value = var.subnet_ids == "" ? aws_subnet.subnet.*.id : [for k, v in data.aws_subnet.subnet : v.id if v.map_public_ip_on_launch == false]
}

output "subnet_ids" {
  value = var.subnet_ids == "" ? aws_subnet.subnet.*.id : split(",", var.subnet_ids)
}

output "subnet_cidrs" {
  value = aws_subnet.subnet.*.cidr_block
}
