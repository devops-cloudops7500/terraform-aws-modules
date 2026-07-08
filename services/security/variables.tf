variable "kms_alias_name" {
  type        = string
  description = "KMS alias suffix."
}

variable "kms_description" {
  type        = string
  description = "KMS key description."
}

variable "deletion_window_in_days" {
  type        = number
  description = "KMS deletion window days."
  default     = 30
}

variable "enable_key_rotation" {
  type        = bool
  description = "Enable key rotation."
  default     = true
}

variable "kms_policy_json" {
  type        = string
  description = "Optional KMS policy JSON."
  default     = null
}

variable "multi_region" {
  type        = bool
  description = "Multi-region KMS key."
  default     = false
}

variable "secret_name" {
  type        = string
  description = "Secrets Manager secret name."
}

variable "secret_description" {
  type        = string
  description = "Secret description."
  default     = "Managed by Terraform"
}

variable "secret_recovery_window_in_days" {
  type        = number
  description = "Secret recovery window days."
  default     = 30
}

variable "secret_string" {
  type        = string
  description = "Optional secret value."
  default     = null
  sensitive   = true
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
