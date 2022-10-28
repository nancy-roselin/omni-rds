output "master_username" {
  description = "The master username"
  value       = aws_rds_cluster.postgresql[*].master_username
  sensitive   = true
}

output "master_password" {
  description = "Master password"
  value       = aws_rds_cluster.postgresql[*].master_password
  sensitive   = true
}

output "database_name" {
  description = "Name for an automatically created database"
  value       = aws_rds_cluster.postgresql[*].database_name
  sensitive   = true
}

output "endpoint" {
  description = "RDS cluster endpoint"
  value       = aws_rds_cluster.postgresql[*].endpoint
}

output "port" {
  description = "The port"
  value       = aws_rds_cluster.postgresql[*].port
}

output "arn" {
  description = "RDS cluster arn"
  value       = aws_rds_cluster.postgresql[*].arn
}

output "id" {
  description = "RDS cluster id"
  value       = aws_rds_cluster.postgresql[*].id
}
