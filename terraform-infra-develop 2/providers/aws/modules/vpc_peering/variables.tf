variable "peer_vpc_id" {
  description = "Peer VPC ID"
  type        = string
  default     = ""
}

variable "origin_vpc_id" {
  description = "origin VPC ID"
  type        = string
  default     = ""
}

variable "auto_accept_peering" {
  description = "Auto accept peering connection"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {}
}

variable "from_origin" {
  description = "If traffic TO peer vpc (from origin) should be allowed"
  type        = bool
  default     = true
}

variable "from_peer" {
  description = "If traffic FROM peer vpc (to origin) should be allowed"
  type        = bool
  default     = true
}

variable "peer_subnets_ids" {
  description = "If communication can only go to some specific subnets of peer vpc. If empty whole vpc cidr is allowed"
  type        = list(string)
  default     = []
}

variable "origin_subnets_ids" {
  description = "If communication can only go to some specific subnets of origin vpc. If empty whole vpc cidr is allowed"
  type        = list(string)
  default     = []
}

variable "origin_rts_ids" {
  description = "Allows to explicitly specify route tables for origin VPC"
  type        = list(string)
  default     = []
}

variable "peer_rts_ids" {
  description = "Allows to explicitly specify route tables for peer VPC"
  type        = list(string)
  default     = []
}
