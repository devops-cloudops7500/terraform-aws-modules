variable "identifier" {
  type        = string
  description = "RDS identifier."
}

variable "engine" {
  type        = string
  description = "DB engine."
}

variable "engine_version" {
  type        = string
  description = "DB engine version."
}

variable "instance_class" {
  type        = string
  description = "DB instance class."
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage GB."
}

variable "max_allocated_storage" {
  type        = number
  description = "Max allocated storage GB."
  default     = 0
}

variable "db_name" {
  type        = string
  description = "Initial database name."
  default     = null
}

variable "username" {
  type        = string
  description = "DB master username."
  sensitive   = true
}

variable "password" {
  type        = string
  description = "DB master password."
  sensitive   = true
}

variable "port" {
  type        = number
  description = "DB port."
  default     = 5432
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ARN/ID for DB storage encryption."
  default     = null
}

variable "storage_type" {
  type        = string
  description = "Storage type."
  default     = "gp3"
}

variable "iops" {
  type        = number
  description = "IOPS value when required by storage class."
  default     = null
}

variable "publicly_accessible" {
  type        = bool
  description = "Public DB endpoint."
  default     = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "DB security groups."
}

variable "subnet_group_name" {
  type        = string
  description = "DB subnet group name."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for DB subnet group."
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention days."
  default     = 7
}

variable "backup_window" {
  type        = string
  description = "Backup window."
  default     = null
}

variable "maintenance_window" {
  type        = string
  description = "Maintenance window."
  default     = null
}

variable "deletion_protection" {
  type        = bool
  description = "Deletion protection."
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot."
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "Apply modifications immediately."
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Auto minor version upgrade."
  default     = true
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Enable Performance Insights."
  default     = true
}

variable "performance_insights_kms_key_id" {
  type        = string
  description = "PI KMS key."
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "Logs to export."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
