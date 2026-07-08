variable "name" {
  type        = string
  description = "Secret name."
}

variable "description" {
  type        = string
  description = "Secret description."
  default     = "Managed by Terraform"
}

variable "kms_key_id" {
  type        = string
  description = "Optional KMS key for secret encryption."
  default     = null
}

variable "recovery_window_in_days" {
  type        = number
  description = "Recovery window days."
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
  description = "Additional tags."
  default     = {}
}
