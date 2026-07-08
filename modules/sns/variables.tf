variable "name" {
  type        = string
  description = "SNS topic name."
}

variable "kms_master_key_id" {
  type        = string
  description = "Optional KMS key for topic encryption."
  default     = null
}

variable "subscriptions" {
  type = map(object({
    protocol = string
    endpoint = string
  }))
  description = "SNS subscriptions map."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
