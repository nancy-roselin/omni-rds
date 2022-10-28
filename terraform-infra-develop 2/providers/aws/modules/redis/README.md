# ***Module for creaing Redis instance***

## Variables for module

| Variable            | default value      |
| --------------------|:------------------:| 
|name                 | omni               |
|engine               | redis              |
|environment          | OMHE-xxx           |
|node_type            | cache.m4.large     |
|num_cache_nodes      | 1                  |
|parameter_group_name | "default.redis6.x" |
|engine_version       | "6.2"              |
|port                 | 6379               |
|subnet_ids           | ""                 |
|security_group_ids   | ""                 |



## **Output form module**
```
output "redis_dns_name" {
  value = aws_elasticache_cluster.redis.cache_nodes.*.address
}
output "redis_port" {
  value = aws_elasticache_cluster.redis.port
}
```