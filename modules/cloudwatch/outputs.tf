output "log_group_names" {
  description = "Created log group names."
  value       = keys(aws_cloudwatch_log_group.this)
}

output "alarm_names" {
  description = "Created alarm names."
  value       = keys(aws_cloudwatch_metric_alarm.this)
}
