output "queue_id" {
  description = "Queue URL."
  value       = aws_sqs_queue.this.id
}

output "queue_arn" {
  description = "Queue ARN."
  value       = aws_sqs_queue.this.arn
}
