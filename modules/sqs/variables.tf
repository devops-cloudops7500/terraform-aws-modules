variable "name" {
  type        = string
  description = "SQS queue name."
}

variable "kms_master_key_id" {
  type        = string
  description = "Optional KMS key for queue encryption."
  default     = "alias/aws/sqs"
}

variable "kms_data_key_reuse_period_seconds" {
  type        = number
  description = "Data key reuse period seconds."
  default     = 300
}

variable "visibility_timeout_seconds" {
  type        = number
  description = "Visibility timeout seconds."
  default     = 30
}

variable "message_retention_seconds" {
  type        = number
  description = "Message retention seconds."
  default     = 345600
}

variable "receive_wait_time_seconds" {
  type        = number
  description = "Long polling wait seconds."
  default     = 10
}

variable "delay_seconds" {
  type        = number
  description = "Delivery delay seconds."
  default     = 0
}

variable "max_message_size" {
  type        = number
  description = "Maximum message size bytes."
  default     = 262144
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
