output "nat_gateway_public_ip" {
  value = [join("", aws_nat_gateway.gw.*.public_ip)] # [aws_nat_gateway.gw[*].public_ip]
}
