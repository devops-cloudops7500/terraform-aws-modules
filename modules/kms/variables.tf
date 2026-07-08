variable "alias_name" {
  type        = string
  description = "KMS alias suffix without alias/ prefix."

  validation {
    condition     = can(regex("^[a-zA-Z0-9/_-]{1,256}$", var.alias_name))
    error_message = "alias_name contains invalid characters."
  }
}

variable "description" {
  type        = string
  description = "Description for KMS key."
}

variable "deletion_window_in_days" {
  type        = number
  description = "Waiting period for KMS key deletion."
  default     = 30

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "deletion_window_in_days must be between 7 and 30."
  }
}

variable "enable_key_rotation" {
  type        = bool
  description = "Enable annual KMS rotation."
  default     = true
}

variable "key_usage" {
  type        = string
  description = "KMS key usage."
  default     = "ENCRYPT_DECRYPT"
}

variable "customer_master_key_spec" {
  type        = string
  description = "KMS key spec."
  default     = "SYMMETRIC_DEFAULT"
}

variable "policy_json" {
  type        = string
  description = "Optional key policy JSON."
  default     = null
}

variable "is_enabled" {
  type        = bool
  description = "Enable key."
  default     = true
}

variable "multi_region" {
  type        = bool
  description = "Create multi-region KMS key."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
