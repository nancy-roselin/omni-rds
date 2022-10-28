variable "subdomain_name" {
  description = "Route 53 domain name for route53 update script in user data"
  type        = string
  default     = "subdomain"
}

variable "domain" {
  description = "URL hostzone"
  type        = string
  default     = "aws-omnicloud.com"

}

variable "name" {
  description = "name of the task"
  type        = string
  default     = "OMHE-xxx"
}

variable "region" {
  description = "The AWS region to create things in."
  type        = string
  default     = "us-west-2"
}

variable "vpc_specific_id" {
  description = "ID of preinstalled VPC (optional)"
  type        = string
  default     = ""
}


variable "associate_public_ip_address" {
  description = "associate_public_ip_address"
  type        = bool
  default     = true
}

variable "instance_count" {
  description = "instance_count"
  type        = string
  default     = "1"
}

variable "instance_type" {
  description = "type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_pair_name" {
  description = "key_pair_name"
  type        = string
  default     = ""
}

variable "key_pair_ssh" {
  description = "private keypair for ec2 instance"
  type        = string
  default     = ""
}

variable "subnet_id" {
  description = "subnet id"
}

variable "volume_type" {
  description = "volume type of instance"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "volume_size_disk"
  type        = string
  default     = 8
}

variable "vpc_id" {
  description = "ID vpc"
  type        = string
}

variable "cidr_block" {
  description = "IP range for VPC"
  type        = string
  default     = "10.20.0.0/16"
}

variable "instance_ami" {
  description = "instance ami"
  type        = string
  default     = "ami-0ca285d4c2cda3300" # Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type (64-bit(x86))
}

variable "ingress_ports" {
  description = "ingress ports"
  type        = list(number)
}

variable "create_ssm_ssh_key_for_ec2" {
  description = "Add ssh key to ssm"
  type        = bool
  default     = true
}

variable "ssh_key_private" {
  description = "ssh key_pair for EC2"
  type        = string
  default     = null
}

variable "key_name" {
  description = "The name for the key pair."
  type        = string
  default     = "ssh_keypair"
}

variable "runner_ip" {
  description = "IP range for access to 22 port for github actions and ansible"
  type        = string
  default     = ""
}

variable "vpc_security_group_id" {
  description = "vpc security group ids"
  type        = list(any)
}


