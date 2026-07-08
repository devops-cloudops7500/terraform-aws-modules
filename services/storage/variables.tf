variable "bucket_name" {
  type        = string
  description = "S3 bucket name."
}

variable "versioning_enabled" {
  type        = bool
  description = "Enable versioning."
  default     = true
}

variable "force_destroy" {
  type        = bool
  description = "Allow deleting non-empty bucket."
  default     = false
}

variable "object_ownership" {
  type        = string
  description = "Object ownership."
  default     = "BucketOwnerEnforced"
}

variable "kms_key_arn" {
  type        = string
  description = "Optional KMS key ARN."
  default     = null
}

variable "enforce_tls" {
  type        = bool
  description = "Enforce TLS."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
