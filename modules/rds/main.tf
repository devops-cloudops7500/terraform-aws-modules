    resource "aws_db_subnet_group" "this" {
    name       = var.subnet_group_name
    subnet_ids = var.subnet_ids
    tags       = merge(var.tags, { Name = var.subnet_group_name })
    }

    resource "aws_db_instance" "this" {
    identifier                      = var.identifier
    engine                          = var.engine
    engine_version                  = var.engine_version
    instance_class                  = var.instance_class
    allocated_storage               = var.allocated_storage
    max_allocated_storage           = var.max_allocated_storage
    db_name                         = var.db_name
    username                        = var.username
    password                        = var.password
    port                            = var.port
    multi_az                        = var.multi_az
    storage_encrypted               = true
    kms_key_id                      = var.kms_key_id
    storage_type                    = var.storage_type
    iops                            = var.iops
    publicly_accessible             = var.publicly_accessible
    vpc_security_group_ids          = var.vpc_security_group_ids
    db_subnet_group_name            = aws_db_subnet_group.this.name
    backup_retention_period         = var.backup_retention_period
    backup_window                   = var.backup_window
    maintenance_window              = var.maintenance_window
    deletion_protection             = var.deletion_protection
    skip_final_snapshot             = var.skip_final_snapshot
    final_snapshot_identifier       = var.skip_final_snapshot ? null : "${var.identifier}-final"
    apply_immediately               = var.apply_immediately
    auto_minor_version_upgrade      = var.auto_minor_version_upgrade
    performance_insights_enabled    = var.performance_insights_enabled
    performance_insights_kms_key_id = var.performance_insights_kms_key_id
    enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
    copy_tags_to_snapshot           = true
    tags                            = merge(var.tags, { Name = var.identifier })
    }
