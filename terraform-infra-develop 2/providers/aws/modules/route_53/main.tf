terraform {
  required_version = ">= 1.1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.4"
    }
  }
}

data "aws_route53_zone" "hosted-zone" {
  name = var.domain
}

resource "aws_route53_record" "public_subdomain" {
  count   = var.add_domain_record ? 1 : 0
  zone_id = data.aws_route53_zone.hosted-zone.id
  name    = var.subdomain_name
  type    = "A"
  ttl     = 300
  records = var.public_ip
}
