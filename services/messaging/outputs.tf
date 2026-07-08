output "sns_topic_arn" {
  description = "SNS topic ARN."
  value       = module.sns.topic_arn
}

output "sqs_queue_arn" {
  description = "SQS queue ARN."
  value       = module.sqs.queue_arn
}
