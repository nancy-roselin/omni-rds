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

variable "create_key_pair" {
  description = "Controls if key pair should be created"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "The name for the key pair."
  type        = string
  default     = "ssh_keypair"
}

variable "key_name_prefix" {
  description = "Creates a unique name beginning with the specified prefix. Conflicts with key_name."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to key pair resource."
  type        = map(string)
  default     = {}
}
