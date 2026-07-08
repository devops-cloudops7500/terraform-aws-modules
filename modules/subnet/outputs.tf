output "subnet_id" {
  description = "Subnet ID."
  value       = aws_subnet.this.id
}

output "subnet_arn" {
  description = "Subnet ARN."
  value       = aws_subnet.this.arn
}
