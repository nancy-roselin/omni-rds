# Module for creating DynamoDB

## For creating DynamoDB:


## Variables and default values

| Variable                          | default value   |
| --------------------------------- |:---------------:| 
| name                              | null            | 
| attributes                        | []              |
| hash_key                          | null            | 
| range_key                         | null            |
| billing_mode                      |"PAY_PER_REQUEST"|
| global_secondary_indexes          | []              |
| write_capacity                    | 5               |
| read_capacity                     | 5               |
| point_in_time_recovery_enabled    | false           |
| ttl_enabled                       | false           |
| ttl_attribute_name                | "               |
| point_in_time_recovery_enabled    | false           |
| server_side_encryption_enabled    | false           |
| server_side_encryption_kms_key_arn| null            |
| tags                              | {}              | 
| timeouts                          |  {              |
                                    |   create = "10m"|
                                    |   update = "60m"|
                                    |   delete = "10m"|
                                    | }               |


## **Output form module**
```
output "dynamodb_table_arn" 
output "dynamodb_table_id" 

```

## **Deploy with a different variables**
```
terraform apply -var='name="Develop_DynamoDB"'
```