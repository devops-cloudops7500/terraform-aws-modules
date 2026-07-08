variable "role_name" {
  type        = string
  description = "IAM role name."
}

variable "role_description" {
  type        = string
  description = "IAM role description."
  default     = "Managed by Terraform"
}

variable "assume_role_principal_type" {
  type        = string
  description = "Principal type in assume role policy."
  default     = "Service"
}

variable "assume_role_principal_identifiers" {
  type        = list(string)
  description = "Principal identifiers in assume role policy."
}

variable "max_session_duration" {
  type        = number
  description = "Role max session duration in seconds."
  default     = 3600

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "max_session_duration must be between 3600 and 43200."
  }
}

variable "path" {
  type        = string
  description = "IAM path for role and custom policies."
  default     = "/"
}

variable "aws_managed_policy_arns" {
  type        = list(string)
  description = "AWS managed policy ARNs to attach."
  default     = []
}

variable "managed_policies" {
  type = map(object({
    description = string
    policy_json = string
  }))
  description = "Custom managed policies to create and attach."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
