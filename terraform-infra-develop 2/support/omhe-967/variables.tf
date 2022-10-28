variable "vpc_id" {
  default = "vpc-0193344062f178cdd"
}
variable "environment" {
  default = "omhe-967"
}
variable "region" {
  default = "us-west-2"
}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "private_subnet_ids" {
  default = ["subnet-0fd3ce5639a4d104d","subnet-0a3ac24a0d3c288ae","subnet-0f2bd0350f3a7d195","subnet-0bdc83df716076d60"]
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
  default     = "omhe-967-rds"
}

variable "db_mysql_instance_class" {
  description = "DB instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_mysql_storage_encrypted" {
  description = "Encript option for DB"
  type        = bool
  default     = true
}

variable "db_mysql_instance_engine" {
  description = "RDS engine type"
  type        = string
  default     = "mysql"
}

variable "db_mysql_instance_engine_version" {
  description = "RDS engine type"
  type        = string
  default     = "8.0.28"
}

variable "db_mysql_name" {
  description = "MySQL DB name"
  type        = string
  default     = "omnidb"
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
  default     = true
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
variable "db_mysql_instance_allocated_storage" {
  default = "200"
}