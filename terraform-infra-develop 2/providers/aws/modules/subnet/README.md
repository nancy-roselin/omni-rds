# **Module for creating Subnet**

This module will create new Subnets

## Variables

| Variable                  | default value           |
| ------------------------- |:-----------------------:| 
| name                      | OMHE-xxx                | 
| vpc_id                    | ""                      |
| az_count                  | 1                       | 
| cidr_block                | "10.20.0.0/24"          | 
| subnet_type               | map (true  = "public" false = "private" |
| subnet_ids                | null                    | 
| map_public_ip_on_launch   | true                    |


## Output form module

'''
output "public_subnets" {
  value = var.subnet_ids == "" ? aws_subnet.subnet.*.id : [for k, v in data.aws_subnet.subnet : v.id if v.map_public_ip_on_launch == true]
}

output "private_subnets" {
  value = var.subnet_ids == "" ? aws_subnet.subnet.*.id : [for k, v in data.aws_subnet.subnet : v.id if v.map_public_ip_on_launch == false]
}
'''