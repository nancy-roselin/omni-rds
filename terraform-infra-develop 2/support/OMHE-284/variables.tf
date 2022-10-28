
### Global variables
variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "account_id" {
  description = "AWS account ID"
  type        = string
}

variable "region" {
  description = "The AWS region to create things in."
  type        = string
  default     = "us-west-2"
}

### VPC variables
variable "ip_range" {
  description = "IP range for VPC"
  type        = string
  default     = ""
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  type        = number
  default     = 1
}

variable "vpc_specific_id" {
  description = "ID of preinstalled VPC (optional)"
  type        = string
}


# Variables for RDS aurora
variable "mysql_mz_instance_count" {
  description = "RDS database master username"
  type        = number
  default     = 1
}

variable "database_name" {
  description = "RDS database name"
  type        = string
  sensitive   = true
  default     = ""
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  default     = true
  type        = bool
}

variable "db_mysql_instance_allocated_storage" {
  description = "Storage size for DB"
  type        = number
  default     = 10
}

variable "rds_subnets" {
  description = "List of RDS subnets"
  type        = list(any)
  default     = []
}

variable "master_username" {
  description = "RDS database master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "create_random_password" {
  description = "create random password for DB"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "Availability zones for MySQL"
  type        = list(any)
  default     = []
}

variable "parameter_group_family" {
  description = "The family of the DB cluster parameter group"
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "DB instance class"
  type        = string
  default     = ""
}

variable "engine_version" {
  description = "RDS engine type"
  type        = string
  default     = ""
}

variable "ingress_rules" {
  description = "Map of lists of maps with SG access rules"
  default     = {}
}

# Variables for RDS DB mysql
variable "db_mysql_instance_create_random_password" {
  description = "create random password for DB"
  type        = bool
  default     = true
}

variable "db_mysql_parameter_group_family" {
  description = "The family of the DB cluster parameter group"
  type        = string
  default     = ""
}

variable "db_mysql_identifier" {
  description = "RDS identifier of DB"
  type        = string
  default     = ""
}

variable "db_mysql_instance_class" {
  description = "DB instance class"
  type        = string
  default     = ""
}

variable "db_mysql_storage_encrypted" {
  description = "Encript option for DB"
  type        = bool
  default     = true
}

variable "db_mysql_instance_engine" {
  description = "RDS engine type"
  type        = string
  default     = ""
}

variable "db_mysql_instance_engine_version" {
  description = "RDS engine type"
  type        = string
  default     = ""
}

variable "db_mysql_name" {
  description = "MySQL DB name"
  type        = string
  default     = ""
}

variable "db_mysql_instance_username" {
  description = "RDS database admin username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "db_mysql_instance_publicly_accessible" {
  description = "control if instance is publicly accessible"
  type        = bool
  default     = false
}

variable "db_mysql_instance_skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "db_mysql_subnets_prefix_name" {
  description = "RDS subnets name prefix"
  type        = string
  default     = "*"
}

variable "db_mysql_deletion_protection" {
  description = "The database can't be deleted when this value is set to true (useful for prod)"
  type        = bool
  default     = true
}
