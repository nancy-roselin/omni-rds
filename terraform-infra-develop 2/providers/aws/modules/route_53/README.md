# **This module for creating Route53 domain records in AWS**

## ***For creating a-record in Route53 service:***

## Adding Route53 record 
- Change variable **add_domain_record** to **true**

| Variable for Route53       | Description                                                   | Default value          | Type          |
| -------------------------- |---------------------------------------------------------------|------------------------| --------------|
|add_domain_record           |Do need to adding domain record                                | false                  |bool           |     
|subdomain_name              |Route 53 domain name for route53 update by script in user data |                        |string         |
|domain                      |Route 53 Hosted zone                                           | azure-omnicloud.com                       |string         |
|public_ip                   |IP for creating A record of subdomain                          |                        |               |

----
>**Important!** 
>Please authorize in AWS before deploying Route53
-----
