# AWS RDS for multiples accounts and regions with Terraform module
* This module simplifies creating and configuring of a database type of RDS, RDS Aurora and RDS Aurora Serverless across multiple accounts and regions on AWS

* Is possible use this module with one region using the standard profile or multi account and regions using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Create file versions.tf with the exemple code below:
```hcl
terraform {
  required_version = ">= 1.1.3"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.9"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 2.0"
    }
  }
}
```

* Criate file provider.tf with the exemple code below:
```hcl
provider "aws" {
  alias   = "alias_profile_a"
  region  = "us-east-1"
  profile = "my-profile"
}

provider "aws" {
  alias   = "alias_profile_b"
  region  = "us-east-2"
  profile = "my-profile"
}
```


## Features enable of RDS configurations for this module:

- Subnet group
- RDS instance database
- RDS cluster
- RDS cluster instance

## Usage exemples

### RDS Mysql

```hcl
module "database_mysql" {
  source                  = "web-virtua-aws-multi-account-modules/rds/aws"
  default_db_name         = "your_db"
  default_user_name       = "your_user"
  default_password        = "your-password"
  identifier_name         = "tf-mysql-database"
  port_database           = 3306
  volume_size             = 30
  max_volume_size         = 60
  storage_type            = "gp3"
  engine                  = "mysql"
  engine_version          = "8.0"
  database_instance_type  = "db.t3.small"
  parameter_group_name    = "default.mysql8.0"
  availability_zone       = "us-east-1a"
  enabled_cloudwatch_logs = ["audit", "error", "general", "slowquery"]

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]
  
  providers = {
    aws = aws.alias_profile_b
  }
}
```

### RDS Postgres

```hcl
module "database_postgres" {
  source                  = "web-virtua-aws-multi-account-modules/rds/aws"
  default_db_name         = "your_db"
  default_user_name       = "your_user"
  default_password        = "your-password"
  identifier_name         = "tf-postgres-database"
  port_database           = 5432
  volume_size             = 30
  max_volume_size         = 65
  storage_type            = "gp3"
  engine                  = "postgres"
  engine_version          = "13.3"
  database_instance_type  = "db.t3.small"
  availability_zone       = "us-east-1a"

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```


### RDS sqlServer

```hcl
module "database_sql_server" {
  source                 = "web-virtua-aws-multi-account-modules/rds/aws"
  default_db_name        = "your_db"
  default_user_name      = "your_user"
  default_password       = "your-password"
  identifier_name        = "tf-sql-server-database"
  port_database          = 1433
  volume_size            = 30
  max_volume_size        = 65
  iops                   = 3000
  storage_throughput     = 125
  storage_type           = "gp3"
  engine                 = "sqlserver-se"
  engine_version         = "12.00.6293.0.v1"
  database_instance_type = "db.m5.large"
  availability_zone      = "us-east-1a"
  license_model          = "license-included"

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### RDS Oracle

```hcl
module "database_oracle" {
  source                  = "web-virtua-aws-multi-account-modules/rds/aws"
  default_db_name         = "your_db"
  default_user_name       = "your_user"
  default_password        = "your-password"
  identifier_name         = "tf-oracle-database"
  port_database           = 1521
  volume_size             = 30
  max_volume_size         = 65
  storage_type            = "gp3"
  engine                  = "oracle-se2"
  engine_version          = "19.0.0.0.ru-2019-07.rur-2019-07.r1"
  database_instance_type  = "db.m5.large"
  availability_zone       = "us-east-1a"
  license_model           = "license-included"

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### RDS Aurora Postgres with two instances

```hcl
module "database_aurora_postgres" {
  source                 = "web-virtua-aws-multi-account-modules/rds/aws"
  type                   = "aurora"
  default_db_name        = "your_db"
  default_user_name      = "your_user"
  default_password       = "your-password"
  identifier_name        = "tf-aurora-postgres"
  port_database          = 5432
  engine                 = "aurora-postgresql"
  engine_version         = "13.7"
  engine_mode            = "provisioned"
  database_instance_type = "db.r5.large"
  availability_zones     = ["us-east-1a", "us-east-1b"]

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### RDS Aurora MySql with two instances

```hcl
module "vpc_main" {
  source                 = "web-virtua-aws-multi-account-modules/rds/aws"
  type                   = "aurora"
  default_db_name        = "your_db"
  default_user_name      = "your_user"
  default_password       = "your-password"
  identifier_name        = "tf-aurora-mysql"
  port_database          = 3306
  volume_size            = 30
  engine                 = "aurora-mysql"
  engine_version         = "8.0.mysql_aurora.3.01.0"
  engine_mode            = "provisioned"
  database_instance_type = "db.r5.large"
  availability_zones     = ["us-east-1a", "us-east-1f"]

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### RDS Aurora Serverless Postgres with two instances

```hcl
module "database_aurora_serverless_postgres" {
  source                 = "web-virtua-aws-multi-account-modules/rds/aws"
  type                   = "aurora"
  default_db_name        = "your_db"
  default_user_name      = "your_user"
  default_password       = "your-password"
  identifier_name        = "tf-aurora-postgres"
  port_database          = 5432
  engine                 = "aurora-postgresql"
  engine_version         = "13.7"
  engine_mode            = "provisioned"
  database_instance_type = "db.serverless"
  availability_zones     = ["us-east-1a", "us-east-1b"]

  serverlessv2_scaling_configuration = {
    min_capacity = 0.5
    max_capacity = 1.0
  }

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

### RDS Aurora Serverless MySql with one instances

```hcl
module "database_aurora_serverless_mysql" {
  source                 = "web-virtua-aws-multi-account-modules/rds/aws"
  type                   = "aurora"
  default_db_name        = "your_db"
  default_user_name      = "your_user"
  default_password       = "your-password"
  identifier_name        = "tf-aurora-serverless-mysql"
  port_database          = 3306
  engine                 = "aurora-mysql"
  engine_version         = "8.0.mysql_aurora.3.02.0"
  engine_mode            = "provisioned"
  database_instance_type = "db.serverless"
  availability_zones     = ["us-east-1a"]

  serverlessv2_scaling_configuration = {
    min_capacity = 0.5
    max_capacity = 2.0
  }

  security_group_ids = [
    "sg-018620a...764c"
  ]

  subnet_ids = [
    "subnet-0eff3...bde8",
    "subnet-0ecce...cfd9"
  ]

  providers = {
    aws = aws.alias_profile_b
  }
}
```

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| subnet_ids | `list(string)` | `-` | yes | Subnet group name, It's necessaty at least two | `-` |
| subnet_group_name | `string` | `null` | no | Subnet group name existing, if not defined will be create a new subnet group | `-` |
| type | `string` | `rds` | no | Type of dtabase, can be rds or aurora| `*`rds <br> `*`aurora |
| default_db_name | `string` | `-` | yes | Default database name | `-` |
| default_user_name | `string` | `-` | yes | Default user name | `-` |
| default_password | `string` | `-` | yes | Default password | `-` |
| volume_size | `number` | `null` | no | Volume size to RDS | `-` |
| max_volume_size | `number` | `null` | no | Max volume size to RDS" | `-` |
| storage_encrypted | `bool` | `false` | no | Enable or desable storage encripty | `*`false <br> `*`true |
| engine | `string` | `-` | yes | Database engine type to RDS | `-` |
| engine_version | `string` | `-` | yes | Database engine version to RDS | `-` |
| database_instance_type | `string` | `db.r5.large` | no | Database instance type | `-` |
| port_database | `number` | `null` | no | Number port to database | `-` |
| publicly_accessible | `bool` | `true` | no | Allow public access | `*`false <br> `*`true |
| parameter_group_name | `string` | `null` | no | Parameter group name | `-` |
| skip_final_snapshot | `bool` | `true` | no | Skip final snapshot when destroy database | `*`false <br> `*`true |
| availability_zone | `string` | `us-east-1` | no | Availability zone, It's only RDS, don't will be apply in RDS Aurora | `-` |
| identifier_name | `string` | `tf-db-rds` | no | Name of identifier database | `-` |
| is_multi_az | `bool` | `false` | no | Is multi AZ | `*`false <br> `*`true |
| security_group_ids | `list(string)` | `-` | yes | Security groups ids, It's necessaty at least one | `-` |
| storage_type | `string` | `null` | no | Storage type to RDS, can be gp3 or io1" | `*`gp3 <br> `*`io1 |
| iops | `number` | `null` | no | Quantity of the IOPS to RDS, Is's only possible specify for storage more then 400GB for mysql and postgres, should has more then 200GB to Oracle and for sql server don't has limit | `-` |
| storage_throughput | `number` | `null` | no | Is's only possible specify for storage more then 400GB for mysql and postgres, should has more then 200GB to Oracle and for sql server don't has limit. The storage throughput value for the DB instance. Can only be set when storage_type is gp3. Cannot be specified if the allocated_storage value is below a per-engine threshold | `-` |
| enabled_cloudwatch_logs | `list(string)` | `null` | no | Enable cloud watch and logs, a list can be diffrent to each RDS type | `-` |
| retention_days_to_backup | `number` | `7` | no | Backup retention days can be between 1 and 35 | `-` |
| backup_window | `string` | `22:00-23:59` | no | Hours range to make backup, use the format: 00:00-00:00 | `-` |
| delete_automated_backups | `bool` | `true` | no | Delete backups automatically | `*`false <br> `*`true |
| snapshot_identifier | `string` | `null` | no | Database snapshot identifier to create database from snapshot | `-` |
| use_tags_default | `bool` | `true` | no | If true will be use the tags default to RDS | `*`false <br> `*`true |
| tags | `map(any)` | `{}` | no | Tags to resources | `-` |
| tags_subnet_group | `map(any)` | `{}` | no | Tags to subnet group | `-` |
| ou_name | `string` | `no` | no | Organization unit name | `-` |
| monitoring_interval | `number` | `null` | no | The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60 | `-` |
| performance_insights_enabled | `bool` | `false` | no | Enable or desable performance insights | `*`false <br> `*`true |
| performance_insights_retention_period | `number` | `null` | no | Save performance insights for a period | `-` |
| performance_insights_kms_key_id | `string` | `null` | no | The ARN for the KMS key to encrypt Performance Insights data. When specifying performance_insights_kms_key_id, performance_insights_enabled needs to be set to true. Once KMS key is set, it can never be changed | `-` |
| allow_major_version_upgrade | `bool` | `null` | no | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | `*`false <br> `*`true |
| apply_immediately | `bool` | `false` | no | Specifies whether any database modifications are applied immediately, or during the next maintenance window | `*`false <br> `*`true |
| character_set_name | `string` | `null` | no | The character set name to use for DB encoding in Oracle and Microsoft SQL instances (collation). This can't be changed | `-` |
| copy_tags_to_snapshot | `bool` | `false` | no | Copy all Instance tags to snapshots | `*`false <br> `*`true |
| deletion_protection | `bool` | `false` | no | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to true | `*`false <br> `*`true |
| domain | `string` | `null` | no | The ID of the Directory Service Active Directory domain to create the instance in | `-` |
| domain_iam_role_name | `string` | `null` | no | (Optional, but required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service | `-` |
| final_snapshot_identifier | `bool` | `false` | no | The name of your final DB snapshot when this DB instance is deleted. Must be provided if skip_final_snapshot is set to false | `*`false <br> `*`true |
| iam_database_authentication_enabled | `bool` | `null` | no | Specifies whether mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `*`false <br> `*`true |
| kms_key_id | `string` | `null` | no | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN | `-` |
| maintenance_window | `string` | `null` | no | The window to perform maintenance in. Syntax: ddd:hh24:mi-ddd:hh24:mi. Ex: Mon:00:00-Mon:03:00 | `-` |
| monitoring_role_arn | `string` | `null` | no | The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs | `-` |
| network_type | `string` | `null` | no | The network type of the DB instance, can be IPV4 or DUAL | `-` |
| replica_mode | `string` | `null` | no | Specifies whether the replica is in either mounted or open-read-only mode. This attribute is only supported by Oracle instances. Oracle replicas operate in open-read-only mode unless otherwise specified | `-` |
| replicate_source_db | `string` | `null` | no | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate (if replicating within a single region) or ARN of the Amazon RDS Database to replicate (if replicating cross-region). Note that if you are creating a cross-region replica of an encrypted database you will also need to specify a kms_key_id | `-` |
| timezone | `string` | `null` | no | Time zone of the DB instance, timezone is currently only supported by Microsoft SQL Server, the timezone can only be set on creation | `-` |
| license_model | `string` | `null` | no | Optional, but required for some DB engines, i.e., Oracle SE1) License model information for this DB instance | `-` |
| restore_to_point_in_time | `list(object)` | `{}` | no | A configuration block for restoring a DB instance to an arbitrary point in time. Requires the identifier argument to be set with the name of the new DB instance to be created | `-` |
| engine_mode | `string` | `provisioned` | no | The database engine mode, can be global (only valid for Aurora MySQL 1.21 and earlier), multimaster, parallelquery, provisioned, serverless | `-` |
| availability_zones | `list(string)` | `["us-east-1a"]` | no | Availability zones | `-` |
| db_instance_parameter_group_name | `string` | `null` | no | Instance parameter group to associate with all instances of the DB cluster. The db_instance_parameter_group_name parameter is only valid in combination with the allow_major_version_upgrade parameter | `-` |
| serverlessv2_scaling_configuration | `list(object)` | `null` | no | Nested attribute with scaling properties for ServerlessV2. Only valid when engine_mode is set to provisioned | `-` |


## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.create_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_db_instance.create_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_rds_cluster.create_cluster_aurora](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_instance.create_cluster_instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `subnet_group` | Subnet group|
| `rds_id` | RDS ID |
| `rds_db_name` | RDS database name |
| `rds_arn` | RDS ARN |
| `rds_endpoint` | RDS endpoint |
| `rds_allocated_storage` | RDS allocated storage |
| `rds_availability_zones` | RDS availability zones |
| `rds_engine_version_actual` | RDS engine version actual |
| `rds_hosted_zone_id` | RDS hosted zone ID |
| `rds_resource_id` | RDS resource ID |
| `rds_backup` | RDS backup |
| `rds` | RDS, sensitive is true |
