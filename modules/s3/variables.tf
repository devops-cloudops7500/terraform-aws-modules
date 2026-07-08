variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "bucket_name must be 3-63 chars and contain lowercase letters, numbers, dots, and hyphens."
  }
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket deletion when objects exist. Keep false in production."
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable S3 versioning."
  default     = true
}

variable "block_public_access" {
  type        = bool
  description = "Enable all S3 public access block settings."
  default     = true
}

variable "object_ownership" {
  type        = string
  description = "S3 object ownership mode."
  default     = "BucketOwnerEnforced"

  validation {
    condition     = contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.object_ownership)
    error_message = "object_ownership must be BucketOwnerEnforced, BucketOwnerPreferred, or ObjectWriter."
  }
}

variable "kms_key_arn" {
  type        = string
  description = "Optional KMS key ARN for SSE-KMS. If null, SSE-S3 (AES256) is used."
  default     = null

  validation {
    condition     = var.kms_key_arn == null || can(regex("^arn:aws(-[a-z]+)?:kms:[a-z0-9-]+:[0-9]{12}:key/[a-f0-9-]+$", var.kms_key_arn))
    error_message = "kms_key_arn must be a valid KMS key ARN or null."
  }
}

variable "allow_tls_requests_only" {
  type        = bool
  description = "Attach policy statement that denies non-TLS requests."
  default     = true
}

variable "bucket_policy_json" {
  type        = string
  description = "Optional JSON policy document merged with module-managed statements."
  default     = null

  validation {
    condition     = var.bucket_policy_json == null || can(jsondecode(var.bucket_policy_json))
    error_message = "bucket_policy_json must be valid JSON when provided."
  }
}

variable "enable_access_logging" {
  type        = bool
  description = "Enable S3 access logging."
  default     = false
}

variable "access_log_bucket_name" {
  type        = string
  description = "Target bucket for access logs. Required when enable_access_logging is true."
  default     = null

  validation {
    condition     = var.enable_access_logging ? var.access_log_bucket_name != null : true
    error_message = "access_log_bucket_name is required when enable_access_logging is true."
  }
}

variable "access_log_prefix" {
  type        = string
  description = "Target prefix for access logs."
  default     = "s3-access-logs/"
}

variable "lifecycle_rules" {
  type = list(object({
    id            = string
    enabled       = bool
    filter_prefix = string
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
    noncurrent_version_transitions = optional(list(object({
      noncurrent_days = number
      storage_class   = string
    })), [])
    expiration_days                    = optional(number)
    noncurrent_version_expiration_days = optional(number)
  }))
  description = "Optional lifecycle rules for transition and expiration."
  default     = []
}

variable "cors_rules" {
  type = list(object({
    allowed_headers = optional(list(string), [])
    allowed_methods = list(string)
    allowed_origins = list(string)
    expose_headers  = optional(list(string), [])
    max_age_seconds = optional(number)
  }))
  description = "Optional CORS rules."
  default     = []
}

variable "object_lock_enabled" {
  type        = bool
  description = "Enable object lock on bucket creation. Cannot be changed after creation."
  default     = false
}

variable "object_lock_mode" {
  type        = string
  description = "Default object lock mode when object lock is enabled."
  default     = null

  validation {
    condition     = var.object_lock_mode != null ? contains(["GOVERNANCE", "COMPLIANCE"], var.object_lock_mode) : true
    error_message = "object_lock_mode must be GOVERNANCE, COMPLIANCE, or null."
  }
}

variable "object_lock_days" {
  type        = number
  description = "Default object lock retention in days. Mutually exclusive with object_lock_years."
  default     = null
}

variable "object_lock_years" {
  type        = number
  description = "Default object lock retention in years. Mutually exclusive with object_lock_days."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to all S3 resources that support tagging."
  default     = {}
}
