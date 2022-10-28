# **This module for creating Security Group domain in AWS**

## ***For creating security group service:***

## Adding variable in main.tf file 
- Add local variable **ingress_rules_name** and **name=local.ingress_rules_name**

```
locals {
  ingress_rules_db = [{ port = "XXXXXX", cidr_blocks = [<cidr_blok_or_IP>], description = "Name_of_security_rule" }]

  sg_ingress_rules = {
    db = local.ingress_rules_db
  }
}
```


| Variable for AWS security groups  | Description                                   | Default value   | Type        |
| ----------------------------------|-----------------------------------------------|-----------------| ------------|
|vpc_id                             | VPC ID for security groups of instance        |                 |             |     
|name                               | RName of task                                 |                 | string      |
|ingress_rules                      | Map of lists of maps with SG access rules     |                 | string      |
|tags                               | IP for creating A record of subdomain         |                 | map(string) |
|create_sg                          | Choise to create security group               | true            | bool        | 




----

###
```bash
output "id" {
  value = aws_security_group.this.*.id
}
```