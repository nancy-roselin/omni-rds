# ***Module for creaing RDS PostgreSQL DB single instance***

## Variables for module

| Variable                             | default value                  |
| ------------------------------------ |:------------------------------:| 
|region                                | "us-west-2"                    |
|environment                           | "omhe-xxx"                     |
|account_id                            | ""                             |
|ip_range                              | "10.10.0.0/16"                 |
|az_count                              | "2"                            |
|vpc_specific_id                       | ""                             |
|master_username                       | "admin"                        |
|db_pg_instance_create_random_password | true                           |
|db_pg_identifier                      | "xxx-database"                 |
|db_pg_instance_class                  | "db.t3.micro"                  |
|db_pg_storage_encrypted               | false                          |
|db_pg_instance_engine                 | "postgres"                     |   
|db_pg_instance_engine_version         | "14.1"                         |
|db_pg_name                            | "mydb"                         |
|db_pg_instance_username               | "testuser"                     |
|db_pg_instance_publicly_accessible    | false                          |
|db_pg_instance_skip_final_snapshot    | true                           |
|db_pg_subnets_prefix_name             | "xxx"                          |
|db_pg_deletion_protection             | false                          |
|db_pg_parameter_group_family          | "aurora5.6"                    |
|db_pg_instance_allocated_storage      | 20                             |



## **Output form module**
```

```

## **Deploy with a different variables**
```
terraform apply -var='resource_tags={project="my-project",environment="development"}'
```