# ***Module for creaing VPC peering between 2 AWS region in the same account***

## Variables for module

| Variable                    | default value           | variable explenation                           |
| ----------------------------|:-----------------------:|:-----------------------------------------------:
|auto_accept_peering          | false                   | peering connection auto accept                 |
|from_peer                    | true                    | allow traffic from peer VPC network            |
|from_origin                  | true                    | allow traffic from origin VPC network          |
|peer_rts_ids                 | []                      | routing table for peer VPC                     |
|peer_subnets_ids             | []                      | limit trafic to specific subnet for peer VPC   |
|peer_vpc_id                  | ""                      | VPC id of peer network                         |
|tags                         | {}                      | map of VPC peering connection tags             |
|origin_rts_ids               | []                      | routing table for origin VPC                   |
|origin_subnets_ids           | []                      | limit trafic to specific subnet for origin VPC |
|origin_vpc_id                | ""                      | VPC id of origin network                       |


## **Usage**
```
provider "aws" {
  alias      = "origin"
  region     = var.origin_region
}

provider "aws" {
  alias      = "peer"
  region     = var.peer_region
}

module "vpc_peering" {
  source = "../modules/vpc_peering"

  providers = {
    aws.origin = aws.origin
    aws.peer = aws.peer
  }

  origin_vpc_id = var.origin_vpc_id
  peer_vpc_id = var.peer_vpc_id

  peer_subnets_ids = var.peer_subnets_ids
  origin_subnets_ids = var.origin_subnets_ids

  auto_accept_peering = true

  tags = var.tags
}
```

## **Variables Example**
```
variable "origin_vpc_id" {
  default = "vpc-xxxxxxxxxx"
}

variable "peer_vpc_id" {
  default = "vpc-yyyyyyyyy"
}

variable "origin_region" {
  default = "us-west-2"
}

variable "peer_region" {
  default = "us-east-1"
}

variable "origin_subnets_ids" {
  type        = list(string)
  default     = ["subnet-xxxxxxxxxx"]
}

variable "peer_subnets_ids" {
  type        = list(string)
  default     = ["subnet-yyyyyyyyy"]
}

variable "tags" {
  description = "Tags"
  type        = map(string)
  default     = {
    Name        = "omhe-XXX-vpc-peering-XXX"
    Environment = "Test"
    Managed_by = "Terraform"
  }
}
```
