variable "name" {
  description = "Name of task"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for security groups of instance"
  type        = string
}

variable "ingress_rules" {
  description = "Map of lists of maps with SG access rules"
  default     = {}
}

variable "tags" {
  type = map(string)
}

variable "create_sg" {
  type    = bool
  default = true
}
