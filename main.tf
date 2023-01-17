locals {
  tags_default = {
    "Name"   = var.default_db_name
    "tf-rds" = var.default_db_name
    "tf-ou"  = var.ou_name
  }

  sub_net_groups_tags = {
    "Name"            = var.default_db_name
    "tf-subnet-group" = var.default_db_name
    "tf-ou"           = var.ou_name
  }
}

resource "aws_db_subnet_group" "create_subnet_group" {
  count = var.subnet_group_name == null ? 1 : 0

  name       = "${var.default_db_name}-subnet-group"
  subnet_ids = var.subnet_ids
  tags       = merge(var.tags_subnet_group, var.use_tags_default ? local.sub_net_groups_tags : {})
}

resource "aws_db_instance" "create_rds" {
  count = var.type == "rds" ? 1 : 0

  db_name                               = substr(var.engine, 0, 9) == "sqlserver" ? null : substr(var.engine, 0, 6) == "oracle" ? substr(replace(var.default_db_name, "/\\W|_|\\s/", ""), 0, 8) : var.default_db_name
  username                              = var.default_user_name
  password                              = var.default_password #max 41 chars
  allocated_storage                     = var.volume_size
  max_allocated_storage                 = var.max_volume_size
  storage_encrypted                     = var.storage_encrypted
  engine                                = var.engine
  engine_version                        = var.engine_version
  instance_class                        = var.database_instance_type
  port                                  = var.port_database
  publicly_accessible                   = var.publicly_accessible
  parameter_group_name                  = var.parameter_group_name
  skip_final_snapshot                   = var.skip_final_snapshot
  availability_zone                     = var.availability_zone
  identifier                            = var.identifier_name
  multi_az                              = var.is_multi_az
  vpc_security_group_ids                = var.security_group_ids
  storage_type                          = var.storage_type != null ? var.storage_type : "gp3"
  iops                                  = var.iops
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs
  backup_retention_period               = var.retention_days_to_backup
  backup_window                         = var.backup_window
  delete_automated_backups              = var.delete_automated_backups
  snapshot_identifier                   = var.snapshot_identifier
  db_subnet_group_name                  = try(aws_db_subnet_group.create_subnet_group[0].name, var.subnet_group_name)
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id
  allow_major_version_upgrade           = var.allow_major_version_upgrade
  apply_immediately                     = var.apply_immediately
  character_set_name                    = var.character_set_name # It's only oracle e SQL server
  copy_tags_to_snapshot                 = var.copy_tags_to_snapshot
  deletion_protection                   = var.deletion_protection
  domain                                = var.domain
  domain_iam_role_name                  = var.domain_iam_role_name
  final_snapshot_identifier             = var.final_snapshot_identifier
  iam_database_authentication_enabled   = var.iam_database_authentication_enabled
  kms_key_id                            = var.kms_key_id
  maintenance_window                    = var.maintenance_window
  monitoring_role_arn                   = var.monitoring_role_arn
  network_type                          = var.network_type
  replica_mode                          = var.replica_mode
  replicate_source_db                   = var.replicate_source_db
  storage_throughput                    = var.storage_throughput
  timezone                              = var.timezone
  license_model                         = var.license_model
  tags                                  = merge(var.tags, var.use_tags_default ? local.tags_default : {})

  dynamic "restore_to_point_in_time" {
    for_each = var.restore_to_point_in_time

    content {
      restore_time                             = each.value.restore_time
      source_db_instance_identifier            = each.value.source_db_instance_identifier
      source_dbi_resource_id                   = each.value.source_dbi_resource_id
      use_latest_restorable_time               = each.value.use_latest_restorable_time
      source_db_instance_automated_backups_arn = each.value.source_db_instance_automated_backups_arn
    }
  }
}

#######################################
# RDS Aurora
#######################################
resource "aws_rds_cluster" "create_cluster_aurora" {
  count = var.type == "aurora" ? 1 : 0
  # allocated_storage = 2
  database_name                       = var.default_db_name
  master_username                     = var.default_user_name
  master_password                     = var.default_password #max 41 chars
  storage_encrypted                   = var.storage_encrypted
  engine                              = var.engine
  engine_version                      = var.engine_version
  engine_mode                         = var.engine_mode # It's only has aurora
  port                                = var.port_database
  db_cluster_parameter_group_name     = var.parameter_group_name
  skip_final_snapshot                 = var.skip_final_snapshot
  cluster_identifier                  = var.identifier_name
  vpc_security_group_ids              = var.security_group_ids
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs
  backup_retention_period             = var.retention_days_to_backup
  preferred_backup_window             = var.backup_window
  snapshot_identifier                 = var.snapshot_identifier
  db_subnet_group_name                = try(aws_db_subnet_group.create_subnet_group[0].name, var.subnet_group_name)
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  apply_immediately                   = var.apply_immediately
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  deletion_protection                 = var.deletion_protection
  final_snapshot_identifier           = var.final_snapshot_identifier
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  kms_key_id                          = var.kms_key_id
  preferred_maintenance_window        = var.maintenance_window
  network_type                        = var.network_type
  db_instance_parameter_group_name    = var.db_instance_parameter_group_name
  tags                                = merge(var.tags, var.use_tags_default ? local.tags_default : {})

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.serverlessv2_scaling_configuration != null ? [1] : []

    content {
      min_capacity = var.serverlessv2_scaling_configuration.min_capacity
      max_capacity = var.serverlessv2_scaling_configuration.max_capacity
    }
  }
}

resource "aws_rds_cluster_instance" "create_cluster_instances" {
  count = var.type == "aurora" ? length(var.availability_zones) : 0

  cluster_identifier                    = aws_rds_cluster.create_cluster_aurora[0].id
  engine                                = aws_rds_cluster.create_cluster_aurora[0].engine
  engine_version                        = aws_rds_cluster.create_cluster_aurora[0].engine_version
  identifier                            = "${var.identifier_name}-instance-${count.index + 1}"
  instance_class                        = var.database_instance_type
  publicly_accessible                   = var.publicly_accessible
  db_parameter_group_name               = var.parameter_group_name
  apply_immediately                     = var.apply_immediately
  monitoring_role_arn                   = var.monitoring_role_arn
  monitoring_interval                   = var.monitoring_interval
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  performance_insights_kms_key_id       = var.performance_insights_kms_key_id

  db_subnet_group_name = var.subnet_group_name
  availability_zone    = var.availability_zones[count.index]

  depends_on = [
    aws_rds_cluster.create_cluster_aurora
  ]
}
