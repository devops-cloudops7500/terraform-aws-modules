variable "log_groups" {
  type = map(object({
    retention_in_days = number
    kms_key_id        = optional(string)
  }))
  description = "Map of log groups keyed by name."
  default     = {}
}

variable "metric_alarms" {
  type = map(object({
    alarm_description   = string
    comparison_operator = string
    evaluation_periods  = number
    metric_name         = string
    namespace           = string
    period              = number
    statistic           = string
    threshold           = number
    treat_missing_data  = string
    dimensions          = map(string)
    alarm_actions       = list(string)
    ok_actions          = list(string)
  }))
  description = "CloudWatch metric alarms keyed by alarm name."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Additional tags."
  default     = {}
}
