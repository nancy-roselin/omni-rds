
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "aws_key_pair" "this" {
  count = var.create_key_pair ? 1 : 0

  key_name        = "${var.name}-${var.key_name}"
  key_name_prefix = var.key_name_prefix
  public_key      = tls_private_key.this.public_key_openssh

  tags = var.tags
}

# resource "aws_ssm_parameter" "this" {
#   name  = "/${var.name}/${var.region}/${var.key_name}"
#   type  = "StringList"
#   value = tls_private_key.this.public_key_openssh
#   tags = {
#     name = var.name
#   }
# }

# resource "local_file" "terraform" {
#   content         = tls_private_key.this.private_key_pem
#   filename        = ".ssh/${var.key_name}.pem"
#   file_permission = "0400"
# }

