output "allocation_id" {
  description = "EIP allocation ID."
  value       = aws_eip.this.id
}

output "public_ip" {
  description = "Allocated public IP."
  value       = aws_eip.this.public_ip
}
