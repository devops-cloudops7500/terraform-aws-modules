variable "aws_region" {
  type        = string
  description = "AWS region for S3 deployment."
}

variable "environment" {
  type        = string
  description = "Environment name."

  validation {
    condition     = contains(["dev", "test", "prod"], lower(var.environment))
    error_message = "environment must be one of dev, test, prod."
  }
}

variable "project_name" {
  type        = string
  description = "Project identifier."
}

variable "owner" {
  type        = string
  description = "Owning team."
}

variable "cost_center" {
  type        = string
  description = "Cost center code."
}

variable "data_classification" {
  type        = string
  description = "Data classification label."
  default     = "internal"
}

variable "additional_tags" {
  type        = map(string)
  description = "Additional default tags."
  default     = {}
}

variable "bucket_name" {
  type        = string
  description = "Globally unique bucket name."
}

variable "force_destroy" {
  type        = bool
  description = "Allow bucket deletion when objects exist."
  default     = false
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable S3 versioning."
  default     = true
}

variable "block_public_access" {
  type        = bool
  description = "Enable all public access block controls."
  default     = true
}

variable "object_ownership" {
  type        = string
  description = "S3 ownership control setting."
  default     = "BucketOwnerEnforced"
}

variable "kms_key_arn" {
  type        = string
  description = "Optional KMS key ARN."
  default     = null
}

variable "allow_tls_requests_only" {
  type        = bool
  description = "Deny non-TLS requests."
  default     = true
}

variable "bucket_policy_json" {
  type        = string
  description = "Optional additional bucket policy JSON."
  default     = null
}

variable "enable_access_logging" {
  type        = bool
  description = "Enable access logging."
  default     = false
}

variable "access_log_bucket_name" {
  type        = string
  description = "Target log bucket."
  default     = null
}

variable "access_log_prefix" {
  type        = string
  description = "Target log prefix."
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
  description = "Optional lifecycle rules."
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
  description = "Enable object lock on bucket creation."
  default     = false
}

variable "object_lock_mode" {
  type        = string
  description = "Object lock default mode."
  default     = null
}

variable "object_lock_days" {
  type        = number
  description = "Default object lock retention in days."
  default     = null
}

variable "object_lock_years" {
  type        = number
  description = "Default object lock retention in years."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Resource-specific tags."
  default     = {}
}
