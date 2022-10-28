# **Module for creating VPC**

This module will create new VPC

## Variables

| Variable                  | default value           |
| ------------------------- |:-----------------------:| 
| name                      | OMHE-xxx                | 
| vpc_id                    | ""                      |
| cidr_block                | "10.20.0.0/16"          | 
| region                    | "us-west-2"             | 



## Output form module

'''
output "vpc_id" {
  value = var.vpc_id == "" ? aws_vpc.vpc[0].id : var.vpc_id
}

output "vpc_cidr_block" {
  value = data.aws_vpc.vpc.cidr_block
}

output "main_route_table_id" {
  value = data.aws_vpc.vpc.main_route_table_id
}
'''