# ***Module for creaing RDS MySQL DB single instance***

## Variables for module

| Variable                                | default value                  |
| --------------------------------------- |:------------------------------:|
|region                                   | "us-west-2"                    |
|environment                              | "omhe-xxx"                     |
|account_id                               | ""                             |
|ip_range                                 | "10.10.0.0/16"                 |
|az_count                                 | "2"                            |
|vpc_specific_id                          | ""                             |
|master_username                          | "admin"                        |
|db_mysql_instance_create_random_password | true                           |
|db_mysql_identifier                      | "xxx-database"                 |
|db_mysql_instance_class                  | "db.t3.micro"                  |
|db_mysql_storage_encrypted               | false                          |
|db_mysql_instance_engine                 | "mysql"                        |   
|db_mysql_instance_engine_version         | "8"                            |
|db_mysql_name                            | "mydb"                         |
|db_mysql_instance_username               | "testuser"                     |
|db_mysql_instance_publicly_accessible    | false                          |
|db_mysql_instance_skip_final_snapshot    | true                           |
|db_mysql_subnets_prefix_name             | "xxx"                          |
|db_mysql_deletion_protection             | false                          |
|db_mysql_instance_allocated_storage      | 100                            |



## **Output form module**
```

```

## **Deploy with a different variables**
```
terraform apply -var='resource_tags={project="my-project",environment="development"}'
```
