variable "subnet_ids" {
  description = "Subnet group name, It's necessaty at least two"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "Subnet group name existing, if not defined will be create a new subnet group"
  type        = string
  default     = null
}

variable "type" {
  description = "Type of dtabase, can be rds or aurora"
  type        = string
  default     = "rds"
}

variable "default_db_name" {
  description = "Default database name"
  type        = string
}

variable "default_user_name" {
  description = "Default user name"
  type        = string
}

variable "default_password" {
  description = "Default password"
  type        = string
}

variable "volume_size" {
  description = "Volume size to RDS"
  type        = number
  default     = null
}

variable "max_volume_size" {
  description = "Max volume size to RDS"
  type        = number
  default     = null
}

variable "storage_encrypted" {
  description = "Enable or desable storage encripty"
  type        = bool
  default     = false
}

variable "engine" {
  description = "Database engine type to RDS"
  type        = string
}

variable "engine_version" {
  description = "Database engine version to RDS"
  type        = string
}

variable "database_instance_type" {
  description = "Database instance type"
  type        = string
  default     = "db.r5.large"
}

variable "port_database" {
  description = "Number port to database"
  type        = number
  default     = null
}

variable "publicly_accessible" {
  description = "Allow public access"
  type        = bool
  default     = true
}

variable "parameter_group_name" {
  description = "Parameter group name"
  type        = string
  default     = null
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroy database"
  type        = bool
  default     = true
}

variable "availability_zone" {
  description = "Availability zone, It's only RDS, don't will be apply in RDS Aurora"
  type        = string
  default     = "us-east-1"
}

variable "identifier_name" {
  description = "Name of identifier database"
  type        = string
  default     = "tf-db-rds"
}

variable "is_multi_az" {
  description = "Is multi AZ"
  type        = bool
  default     = false
}

variable "security_group_ids" {
  description = "Security groups ids, It's necessaty at least one"
  type        = list(string)
}

variable "storage_type" {
  description = "Storage type to RDS, can be gp3 or io1"
  type        = string
  default     = null
}

variable "iops" {
  description = "Quantity of the IOPS to RDS, Is's only possible specify for storage more then 400GB for mysql and postgres, should has more then 200GB to Oracle and for sql server don't has limit"
  type        = number
  default     = null
}

variable "storage_throughput" {
  description = "Is's only possible specify for storage more then 400GB for mysql and postgres, should has more then 200GB to Oracle and for sql server don't has limit. The storage throughput value for the DB instance. Can only be set when storage_type is gp3. Cannot be specified if the allocated_storage value is below a per-engine threshold"
  type        = number
  default     = null
}

variable "enabled_cloudwatch_logs" {
  description = "Enable cloud watch and logs, a list can be diffrent to each RDS type"
  type        = list(string)
  default     = null
}

variable "retention_days_to_backup" {
  description = "Backup retention days can be between 1 and 35"
  type        = number
  default     = 7
}

variable "backup_window" {
  description = "Hours range to make backup, use the format: 00:00-00:00"
  type        = string
  default     = "22:00-23:59"
}

variable "delete_automated_backups" {
  description = "Delete backups automatically"
  type        = bool
  default     = true
}

variable "snapshot_identifier" {
  description = "Database snapshot identifier to create database from snapshot"
  type        = string
  default     = null
}

variable "use_tags_default" {
  description = "If true will be use the tags default to RDS"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to load RDS"
  type        = map(any)
  default     = {}
}

variable "tags_subnet_group" {
  description = "Tags to subnet group"
  type        = map(any)
  default     = {}
}

variable "ou_name" {
  description = "Organization unit name"
  type        = string
  default     = "no"
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60"
  type        = number
  default     = null
}

variable "performance_insights_enabled" {
  description = "Enable or desable performance insights"
  type        = bool
  default     = false
}

variable "performance_insights_retention_period" {
  description = "Save performance insights for a period"
  type        = number
  default     = null
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true. Once KMS key is set, it can never be changed"
  type        = string
  default     = null
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible"
  type        = bool
  default     = null
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle and Microsoft SQL instances (collation). This can't be changed"
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots"
  type        = bool
  default     = false
}

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true"
  type        = bool
  default     = false
}

variable "domain" {
  description = "The ID of the Directory Service Active Directory domain to create the instance in"
  type        = string
  default     = null
}

variable "domain_iam_role_name" {
  description = "(Optional, but required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service"
  type        = string
  default     = null
}

variable "final_snapshot_identifier" {
  description = "The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false"
  type        = bool
  default     = false
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  type        = bool
  default     = null
}

variable "kms_key_id" {
  description = "The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN"
  type        = string
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi. Ex: Mon:00:00-Mon:03:00"
  type        = string
  default     = null
}

variable "monitoring_role_arn" {
  description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs"
  type        = string
  default     = null
}

variable "network_type" {
  description = "The network type of the DB instance, can be IPV4 or DUAL"
  type        = string
  default     = null
}

variable "replica_mode" {
  description = "Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specified"
  type        = string
  default     = null
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate (if replicating within a single region) or ARN of the Amazon RDS Database to replicate (if replicating cross-region). Note that if you are creating a cross-region replica of an encrypted database you will also need to specify a kms_key_id"
  type        = string
  default     = null
}

variable "timezone" {
  description = "Time zone of the DB instance, timezone is currently only supported by Microsoft SQL Server, the timezone can only be set on creation"
  type        = string
  default     = null
}

variable "license_model" {
  description = "Optional, but required for some DB engines, i.e., Oracle SE1) License model information for this DB instance"
  type        = string
  default     = null
}

variable "restore_to_point_in_time" {
  description = "A configuration block for restoring a DB instance to an arbitrary point in time. Requires the identifier argument to be set with the name of the new DB instance to be created"
  type = list(object({
    restore_time                             = optional(string)
    source_db_instance_identifier            = optional(string)
    source_dbi_resource_id                   = optional(string)
    use_latest_restorable_time               = optional(bool)
    source_db_instance_automated_backups_arn = optional(string)
  }))
  default = []
}

#######################################
# RDS Cluster Variables
#######################################
variable "engine_mode" {
  description = "The database engine mode, can be global (only valid for Aurora MySQL 1.21 and earlier), multimaster, parallelquery, provisioned, serverless"
  type        = string
  default     = "provisioned"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-1a"]
}

variable "db_instance_parameter_group_name" {
  description = "Instance parameter group to associate with all instances of the DB cluster. The db_instance_parameter_group_name parameter is only valid in combination with the allow_major_version_upgrade parameter"
  type        = string
  default     = null
}

variable "serverlessv2_scaling_configuration" {
  description = "Nested attribute with scaling properties for ServerlessV2. Only valid when engine_mode is set to provisioned"
  type = object({
    max_capacity = number
    min_capacity = number
  })
  default = null
}
