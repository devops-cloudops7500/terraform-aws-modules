variable "bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9.-]{1,61}[a-z0-9]$", var.bucket_name))
    error_message = "Invalid S3 bucket name."
  }
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable S3 bucket versioning."
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = "Allow deleting non-empty bucket. Keep false in production."
  default     = false
}

variable "object_ownership" {
  type        = string
  description = "S3 object ownership mode."
  default     = "BucketOwnerEnforced"

  validation {
    condition     = contains(["BucketOwnerEnforced", "BucketOwnerPreferred", "ObjectWriter"], var.object_ownership)
    error_message = "Invalid object_ownership."
  }
}

variable "kms_key_arn" {
  type        = string
  description = "Optional KMS key ARN."
  default     = null
}

variable "enforce_tls" {
  type        = bool
  description = "Enforce TLS-only requests via bucket policy."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
