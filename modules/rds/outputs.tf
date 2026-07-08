output "db_instance_identifier" {
  description = "DB identifier."
  value       = aws_db_instance.this.identifier
  #value       = aws_db_instance.this.id
}

output "db_instance_endpoint" {
  description = "DB endpoint."
  value       = aws_db_instance.this.endpoint
}

output "db_instance_arn" {
  description = "DB ARN."
  value       = aws_db_instance.this.arn
}
