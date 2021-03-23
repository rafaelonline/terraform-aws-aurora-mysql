output "aurora_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = element(concat(aws_rds_cluster.this.*.endpoint, [""]), 0)
}

output "aurora_cluster_endpoint_port" {
  description = "The port"
  value       = element(concat(aws_rds_cluster.this.*.port, [""]), 0)
}

output "aws_rds_cluster_password" {
  description = "The database password"
  value       = element(concat(aws_rds_cluster.this.*.master_password, [""]), 0)
  sensitive   = false
}