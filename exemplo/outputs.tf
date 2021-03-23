output aurora_cluster_endpoint {
  value       = module.aurora.aurora_cluster_endpoint
  description = "description"
}

output aurora_cluster_endpoint_port {
  value       = module.aurora.aurora_cluster_endpoint_port
  description = "description"
}

output "aws_rds_cluster_password" {
  description = "The database password"
  value       = module.aurora.aws_rds_cluster_password
  sensitive   = false
}