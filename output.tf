output "subnet_group" {
  description = "Subnet group"
  value       = try(aws_db_subnet_group.create_subnet_group[0], null)
}

output "rds" {
  description = "RDS"
  value       = try(aws_db_instance.create_rds[0], aws_rds_cluster.create_cluster_aurora[0])
  sensitive   = true
}

output "rds_id" {
  description = "RDS ID"
  value       = try(aws_db_instance.create_rds[0].id, aws_rds_cluster.create_cluster_aurora[0].id)
}

output "rds_db_name" {
  description = "RDS database name"
  value       = try(aws_db_instance.create_rds[0].db_name, aws_rds_cluster.create_cluster_aurora[0].database_name)
}

output "rds_arn" {
  description = "RDS ARN"
  value       = try(aws_db_instance.create_rds[0].arn, aws_rds_cluster.create_cluster_aurora[0].arn)
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = try(aws_db_instance.create_rds[0].endpoint, aws_rds_cluster.create_cluster_aurora[0].endpoint)
}

output "rds_allocated_storage" {
  description = "RDS allocated storage"
  value       = try(aws_db_instance.create_rds[0].allocated_storage, aws_rds_cluster.create_cluster_aurora[0].allocated_storage)
}

output "rds_availability_zones" {
  description = "RDS availability zones"
  value       = try(aws_db_instance.create_rds[0].availability_zone, aws_rds_cluster.create_cluster_aurora[0].availability_zones)
}

output "rds_engine_version_actual" {
  description = "RDS engine version actual"
  value       = try(aws_db_instance.create_rds[0].engine_version_actual, aws_rds_cluster.create_cluster_aurora[0].engine_version_actual)
}

output "rds_hosted_zone_id" {
  description = "RDS hosted zone ID"
  value       = try(aws_db_instance.create_rds[0].hosted_zone_id, aws_rds_cluster.create_cluster_aurora[0].hosted_zone_id)
}

output "rds_resource_id" {
  description = "RDS resource ID"
  value       = try(aws_db_instance.create_rds[0].resource_id, aws_rds_cluster.create_cluster_aurora[0].cluster_resource_id)
}

output "rds_backup" {
  description = "RDS backup"
  value = {
    retention_days = try(aws_db_instance.create_rds[0].backup_retention_period, aws_rds_cluster.create_cluster_aurora[0].backup_retention_period)
    backup_window  = try(aws_db_instance.create_rds[0].backup_window, aws_rds_cluster.create_cluster_aurora[0].preferred_backup_window)
  }
}
