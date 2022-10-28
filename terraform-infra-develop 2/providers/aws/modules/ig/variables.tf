variable "name" {
  description = "Name. of task"
  type        = string
}

variable "vpc_specific_id" {
  description = "ID of preinstalled VPC (optional)"
  type        = string
}

variable "main_route_table_id" {
  description = "main route table_id"
  type        = string
}

variable "subnet_id_public" {
  description = "Subnet id for public subnets"
}

variable "subnet_id_private" {
  description = "Subnet id for private subnets"
}

variable "vpc_id" {
  description = "ID vpc"
  type        = string
}
