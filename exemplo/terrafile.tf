module "aurora" {
  source         = "./../"
  subnets        = ["subnet-6a482535", "subnet-9d0b6bfb"]
  security_group = ["sg-40ab664e"]

  name                         = "apidatabase"
  engine                       = "aurora-mysql"
  engine_mode                  = "provisioned"
  engine_version               = "5.7.mysql_aurora.2.09.0"
  replica_count                = 2
  instance_type                = "db.t3.small"
  database_name                = "catalog"
  username                     = "user"
  endpoint_identifier          = "static"
  deletion_protection          = "false"
  backup_retention_period      = 7
  preferred_backup_window      = "02:00-03:00"
  preferred_maintenance_window = "sun:05:00-sun:06:00"
  backtrack_window             = 21600 #6 horas

  enabled_cloudwatch_logs_exports = ["error", "slowquery", "audit"]
}