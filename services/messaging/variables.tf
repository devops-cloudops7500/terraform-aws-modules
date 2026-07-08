variable "sns_topic_name" {
  type        = string
  description = "SNS topic name."
}

variable "sns_kms_master_key_id" {
  type        = string
  description = "KMS key for SNS encryption."
  default     = null
}

variable "sns_subscriptions" {
  type = map(object({
    protocol = string
    endpoint = string
  }))
  description = "SNS subscriptions."
  default     = {}
}

variable "sqs_queue_name" {
  type        = string
  description = "SQS queue name."
}

variable "sqs_kms_master_key_id" {
  type        = string
  description = "KMS key for SQS encryption."
  default     = "alias/aws/sqs"
}

variable "sqs_kms_data_key_reuse_period_seconds" {
  type        = number
  description = "KMS data key reuse period."
  default     = 300
}

variable "sqs_visibility_timeout_seconds" {
  type        = number
  description = "Visibility timeout."
  default     = 30
}

variable "sqs_message_retention_seconds" {
  type        = number
  description = "Message retention seconds."
  default     = 345600
}

variable "sqs_receive_wait_time_seconds" {
  type        = number
  description = "Receive wait time."
  default     = 10
}

variable "sqs_delay_seconds" {
  type        = number
  description = "Queue delivery delay."
  default     = 0
}

variable "sqs_max_message_size" {
  type        = number
  description = "Max message size bytes."
  default     = 262144
}

variable "subscribe_sqs_to_sns" {
  type        = bool
  description = "Subscribe queue to topic."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
