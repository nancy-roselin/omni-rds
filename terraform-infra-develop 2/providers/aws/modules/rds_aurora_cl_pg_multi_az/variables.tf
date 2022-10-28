variable "environment" {
  description = "Environment Name"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "instance_count" {
  description = "RDS instances count"
  type        = number
  default     = 1
}

variable "storage_encrypted" {
  description = "Enable storage encryption"
  default     = true
  type        = bool
}

variable "database_name" {
  description = "RDS database name"
  type        = string
  sensitive   = true
}

variable "master_username" {
  description = "RDS database master username"
  type        = string
  default     = "admin"
  sensitive   = true
}

variable "create_random_password" {
  description = "Whether to create random password for RDS primary cluster"
  type        = bool
  default     = true
}

variable "master_password" {
  description = "RDS database password. Note - when specifying a value here, 'create_random_password' should be set to `false`"
  type        = string
  sensitive   = true
  default     = ""
}

variable "backup_retention_period" {
  description = "The days to retain backups for"
  type        = number
  default     = 30
}

variable "backup_window" {
  description = "Prefede backup windows"
  default     = "15:00-17:00"
  type        = string
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot"
  type        = bool
  default     = true
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = true
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(any)
}

variable "vpc_id" {
  description = "VPC ID for RDS cluster"
  type        = string
}

variable "ip_range" {
  description = "IP range for VPC"
  type        = string
}

variable "rds_subnets" {
  type = list(any)
}

variable "deletion_protection" {
  description = "The database can't be deleted when this value is set to true (useful for prod)"
  type        = bool
  default     = true
}

# Parameter group
variable "parameter_group_family" {
  description = "The family of the DB cluster parameter group"
  type        = string
}

variable "vpc_security_group_ids" {
  description = "List of VPC SGs"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "instance_class" {
  description = "DB instance class"
  type        = string
}

variable "engine_version" {
  description = "DB engine version"
  type        = string
}
