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

variable "cidr_block" {
  description = "IP range for VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "region" {
  description = "The AWS region to create things in."
  type        = string
  default     = "us-west-2"
}

