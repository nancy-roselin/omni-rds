resource "aws_elasticache_subnet_group" "elastic_subnet_group" {
  name       = "${var.name}-cache-subnet"
  subnet_ids = var.subnet_ids
}
resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.name}-redis"
  engine               = var.engine
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  parameter_group_name = var.parameter_group_name
  engine_version       = var.engine_version
  port                 = var.port
  security_group_ids   = var.security_group_ids
  subnet_group_name    = aws_elasticache_subnet_group.elastic_subnet_group.name
}
