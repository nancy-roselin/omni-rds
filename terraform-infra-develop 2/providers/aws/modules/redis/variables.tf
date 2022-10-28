variable "name" {
  type    = string
  default = "omni"
}
variable "engine" {
  type    = string
  default = "redis"
}
variable "node_type" {
  type    = string
  default = "cache.m4.large"
}
variable "num_cache_nodes" {
  type    = number
  default = 1
}
variable "parameter_group_name" {
  type    = string
  default = "default.redis6.x"
}
variable "engine_version" {
  type    = string
  default = "6.2"
}
variable "port" {
  type    = number
  default = 6379
}
variable "subnet_ids" {
  default = ""
}
variable "security_group_ids" {
  default = ""
}
