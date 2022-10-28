# **Module for creating vpc_endpoint**

## Example for using module:


```
module "vpc_endpoint" {
  source    = "../modules/vpc_endpoint"
  vpc_id    = "some id of vpc"
  endpoints = {
    dynamodb = {
      service         = "dynamodb"
      service_type    = "Gateway"
      policy          = data.aws_iam_policy_document.<name of policy document>.json
      tags            = { Name = "dynamodb-vpc-endpoint" }
    }
  }
}
```

## Variables

| Variable                  | default value           |
| ------------------------- |:-----------------------:| 
| create                    | true                    | 
| vpc_id                    | required field          |
| endpoints                 | {}                      | 
| security_group_ids        | []                      | 
| subnet_ids                | []                      | 
| tags                      | {}                      | 
| timeouts                  | {}                      | 


## Output form module

- endpoints = Array containing the full resource object and attributes for all endpoints created