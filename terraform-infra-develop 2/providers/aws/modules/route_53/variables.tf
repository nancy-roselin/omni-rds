variable "subdomain_name" {
  description = "Route 53 domain name for route53 update by script in user data"
  type        = string
  default     = "subdomain_name"
}

variable "domain" {
  description = "Route 53 DNS"
  type        = string
}

variable "public_ip" {
  description = "IP for creating A record of subdomain"
}

variable "add_domain_record" {
  description = "Do need to adding domain record"
  type        = bool
  default     = true
}
