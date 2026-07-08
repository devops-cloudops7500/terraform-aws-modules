variable "identifier" {
  type        = string
  description = "RDS identifier."
}

variable "engine" {
  type        = string
  description = "Database engine."
}

variable "engine_version" {
  type        = string
  description = "Database engine version."
}

variable "instance_class" {
  type        = string
  description = "RDS instance class."
}

variable "allocated_storage" {
  type        = number
  description = "Allocated storage (GB)."
}

variable "max_allocated_storage" {
  type        = number
  description = "Max autoscaled storage (GB)."
  default     = 0
}

variable "db_name" {
  type        = string
  description = "Initial DB name."
  default     = null
}

variable "username" {
  type        = string
  description = "Master username."
  sensitive   = true
}

variable "password" {
  type        = string
  description = "Master password."
  sensitive   = true
}

variable "port" {
  type        = number
  description = "Database port."
  default     = 5432
}

variable "multi_az" {
  type        = bool
  description = "Enable Multi-AZ."
  default     = true
}

variable "kms_key_id" {
  type        = string
  description = "KMS key ARN/ID for storage encryption."
  default     = null
}

variable "storage_type" {
  type        = string
  description = "Storage type."
  default     = "gp3"
}

variable "iops" {
  type        = number
  description = "IOPS value for provisioned IOPS."
  default     = null
}

variable "publicly_accessible" {
  type        = bool
  description = "Publicly accessible database."
  default     = false
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "Security group IDs."
}

variable "subnet_group_name" {
  type        = string
  description = "DB subnet group name."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for DB subnet group."
}

variable "backup_retention_period" {
  type        = number
  description = "Backup retention days."
  default     = 7
}

variable "backup_window" {
  type        = string
  description = "Preferred backup window."
  default     = null
}

variable "maintenance_window" {
  type        = string
  description = "Preferred maintenance window."
  default     = null
}

variable "deletion_protection" {
  type        = bool
  description = "Enable deletion protection."
  default     = true
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Skip final snapshot on destroy."
  default     = false
}

variable "apply_immediately" {
  type        = bool
  description = "Apply changes immediately."
  default     = false
}

variable "auto_minor_version_upgrade" {
  type        = bool
  description = "Enable minor version upgrades."
  default     = true
}

variable "performance_insights_enabled" {
  type        = bool
  description = "Enable Performance Insights."
  default     = true
}

variable "performance_insights_kms_key_id" {
  type        = string
  description = "KMS key for Performance Insights."
  default     = null
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "Log exports."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
