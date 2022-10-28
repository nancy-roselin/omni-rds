variable "environment" {
  description = "Environment Name"
  type        = string
  default     = "omhe-xxx"
}

variable "cidr_blocks" {
  description = "Postgres cidr blocks"
  type        = string
}

variable "subnets_prefix_name" {
  description = "RDS subnets name prefix"
  type        = string
  default     = "xxx"
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  default     = false
  type        = bool
}

variable "master_username" {
  description = "RDS database master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "create_random_password" {
  description = "Whether to create random password for RDS DB"
  type        = bool
  default     = true
}

variable "master_password" {
  description = "RDS database password. Note - when specifying a value here, 'create_random_password' should be set to `false`"
  type        = string
  sensitive   = true
  default     = ""
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "identifier" {
  description = "RDS identifier of DB"
  type        = string
  default     = "xxx-database"
}

variable "vpc_id" {
  description = "VPC ID for RDS cluster"
  type        = string
}

variable "vpc_specific_id" {
  description = "ID if pre-installed vpc"
  type        = string
  default     = ""
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true (useful for prod)"
  type        = bool
  default     = false
}

# Parameter group
variable "parameter_group_family" {
  description = "The family of the DB cluster parameter group"
  type        = string
  default     = "aurora5.6"
}

variable "private_subnet_ids" {
  description = "List of VPC Private Subnets"
}


variable "instance_class" {
  description = "DB instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Storage size for DB"
  type        = number
  default     = 20
}

variable "engine_version" {
  description = "DB engine version"
  type        = string
  default     = "14.1"
}

variable "engine" {
  description = "RDS engine type"
  type        = string
  default     = "postgres"
}

variable "db_name" {
  description = "Postgres DB name"
  type        = string
  default     = "mydb"

}

variable "username" {
  description = "RDS database admin username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "publicly_accessible" {
  description = "control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_ids"
  type        = list(any)
  default     = []
}
