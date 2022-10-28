# ***Module for creaing EC2 instance***

## Variables for module

| Variable                    | default value           |
| ----------------------------|:-----------------------:| 
|subdomain_name               | subdomain               |
|domain                       | aws-omnicloud.com       |
|environment                  | OMHE-xxx                |
|vpc_specific_id              | ""                      |
|associate_public_ip_address  | true                    |
|instance_count               | "1"                     |
|instance_type                | "t2.micro"              |
|key_pair_name                | ""                      |
|volume_size                  | 8                       |
|volume_type                  | "gp2"                   |
|cidr_block                   | "10.20.0.0/16"          |
|instance_ami                 | "ami-0ca285d4c2cda3300" |
|ingress_ports                | [8080, 8443, 22]        |
|create_ssm_ssh_key_for_ec2   | true                    |
|"runner_ip                   |  ""                     |


## **Output form module**
```

```

## **Deploy with a different variables**
```
terraform destroy -var="key_pair_name=<my-keypair>" -var="environment=<TASK>" -var="runner_ip=<IP>/32"
```

## **Setup Tomcat with ansible**

Setup triggered during create **resource "aws_instance" "webserver"**


## Deploy infrastructure by Terraform
Add local variables:
Add name of key_pair for instance:
```
 export KEY_PAIR_NAME=oa-west2-keypair
 ```
Add name of task or other name for environment
```
export NAME=OMHE-XXX
 ```
 Add IP to security group for checking infrestucture or deploy ansible
 ```
 export MY_PUB_IP=X.X.X.X
 ```
Add opened ports to security group 
```
export TOMCAT_INGRESS_PORTS= 8080,\ 8443,\ 22
```
Add local variable for deploy or destroy infrastucture
export TERRAFORM_ACTION=apply
export TERRAFORM_ACTION=destroy
```
Run bash script for create terraform.tfvars file and run Deploy/Destroy
```
bash apply.sh
```

