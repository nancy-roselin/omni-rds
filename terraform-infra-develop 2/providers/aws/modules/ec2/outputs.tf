output "instance" {
  value = aws_instance.webserver.*.id
}

output "pub_ip_addr" {
  value = aws_instance.webserver.*.public_ip
}

output "priv_ip_addr" {
  value = aws_instance.webserver.*.private_ip
}

output "eni" {
  value = aws_instance.webserver.*.primary_network_interface_id
}

