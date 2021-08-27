resource "aws_db_subnet_group" "this" {
  count = var.db_subnet_group_name == "" ? 1 : 0

  name        = var.name
  description = "For Aurora cluster ${var.name}"
  subnet_ids  = var.subnets
}

resource "aws_rds_cluster" "this" {
  global_cluster_identifier           = var.global_cluster_identifier
  cluster_identifier                  = var.name
  replication_source_identifier       = var.replication_source_identifier
  source_region                       = var.source_region
  engine                              = var.engine
  engine_mode                         = var.engine_mode
  engine_version                      = var.engine_version
  enable_http_endpoint                = var.enable_http_endpoint
  kms_key_id                          = var.kms_key_id
  database_name                       = var.database_name
  master_username                     = var.username
  master_password                     = var.password != "" ? var.password : join("", random_password.password.*.result)
  final_snapshot_identifier           = "${var.final_snapshot_identifier_prefix}-${var.name}-${random_id.snapshot_identifier.hex}"
  skip_final_snapshot                 = var.skip_final_snapshot
  deletion_protection                 = var.deletion_protection
  backup_retention_period             = var.backup_retention_period
  preferred_backup_window             = var.preferred_backup_window
  preferred_maintenance_window        = var.preferred_maintenance_window
  port                                = var.port
  db_subnet_group_name                = join("", aws_db_subnet_group.this.*.name)
  vpc_security_group_ids              = compact(concat(var.security_group, var.vpc_security_group_ids))
  snapshot_identifier                 = var.snapshot_identifier
  storage_encrypted                   = var.storage_encrypted
  apply_immediately                   = var.apply_immediately
  db_cluster_parameter_group_name     = var.db_cluster_parameter_group_name
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  backtrack_window                    = var.backtrack_window
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  iam_roles                           = var.iam_roles

  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports

  tags = {
    Build_from = var.build
  }
}

resource "aws_rds_cluster_instance" "this" {
  count = var.replica_count

  identifier                   = "${var.name}-${count.index + 1}"
  cluster_identifier           = aws_rds_cluster.this.id
  engine                       = var.engine
  engine_version               = var.engine_version
  instance_class               = var.instance_type
  publicly_accessible          = var.publicly_accessible
  db_subnet_group_name         = join("", aws_db_subnet_group.this.*.name)
  db_parameter_group_name      = var.db_parameter_group_name
  preferred_maintenance_window = var.preferred_maintenance_window
  apply_immediately            = var.apply_immediately
  monitoring_role_arn          = join("", aws_iam_role.rds_enhanced_monitoring.*.arn)
  monitoring_interval          = var.monitoring_interval
  auto_minor_version_upgrade   = var.auto_minor_version_upgrade
  promotion_tier               = count.index + 1
  ca_cert_identifier           = var.ca_cert_identifier
}

resource "random_id" "snapshot_identifier" {
  keepers = {
    id = var.name
  }

  byte_length = 4
}

resource "random_password" "password" {
  count            = var.password == "" ? 1 : 0
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  count = var.monitoring_interval > 0 ? 1 : 0

  name               = "rds-enhanced-monitoring-${var.name}"
  assume_role_policy = data.aws_iam_policy_document.monitoring_rds_assume_role.json

  permissions_boundary = var.permissions_boundary
}

resource "aws_iam_role_policy_attachment" "rds_enhanced_monitoring" {
  count = var.monitoring_interval > 0 ? 1 : 0

  role       = join("", aws_iam_role.rds_enhanced_monitoring.*.name)
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}