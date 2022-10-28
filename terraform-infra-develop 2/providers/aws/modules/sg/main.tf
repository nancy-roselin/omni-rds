terraform {
  required_version = ">= 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0.0"
    }
  }
}

resource "aws_security_group" "this" {
  count       = var.create_sg ? 1 : 0
  name_prefix = "${var.name}_security_group"
  description = "SG for ${var.name}"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules

    content {
      from_port       = element(split("-", ingress.value.port), 0)
      to_port         = element(split("-", ingress.value.port), 1)
      protocol        = "tcp"
      cidr_blocks     = lookup(ingress.value, "cidr_blocks", [])
      security_groups = lookup(ingress.value, "security_groups", [])
      description     = lookup(ingress.value, "description", "")
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.name}-SG"
    Environment = var.name
  }

  lifecycle { create_before_destroy = true }
}
output "sgid" {
  value= aws_security_group.this[0].id
}