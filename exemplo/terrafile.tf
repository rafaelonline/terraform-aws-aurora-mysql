/*locals {
  vpc_id = data.terraform_remote_state.infra.outputs.vpc_id
  private_subnets_id = data.terraform_remote_state.infra.outputs.private_subnets_id
  security_group_id = data.terraform_remote_state.infra.outputs.security_group_aurora_id


}*/

module "aurora" {
  source = "./modules/aurora"
  #subnets             = local.private_subnets_id
  #security_group      = [local.security_group_id]
  subnets        = ["subnet-6a482535", "subnet-9d0b6bfb"]
  security_group = ["sg-40ab664e"]

  #password = "123qwE.." # -> Caso uma senha não seja informada, será gerado uma automatica

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

  ### TAGS ###
  owner       = "labs"
  environment = "dev"
}