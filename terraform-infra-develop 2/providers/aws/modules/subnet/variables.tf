variable "name" {
  description = "Name of task"
  type        = string
  default     = "OMHE-xxx"
}

variable "vpc_id" {
  description = "ID of vpc"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "Subnet of vpc"
  default     = null
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  type        = number
  default     = 1
}

variable "cidr_block" {
  description = "IP range for VPC"
  type        = string
  default     = "10.20.0.0/24"
}

variable "subnet_type" {
  type = map(string)
  default = {
    true  = "public"
    false = "private"
  }
}

variable "map_public_ip_on_launch" {
  type    = bool
  default = true
}
