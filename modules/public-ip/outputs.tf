output "allocation_id" {
  description = "Elastic IP allocation ID."
  value       = aws_eip.this.id
}

output "public_ip" {
  description = "Elastic public IPv4 address."
  value       = aws_eip.this.public_ip
}

output "association_id" {
  description = "Elastic IP association ID, if associated."
  value       = one(aws_eip_association.this[*].id)
}
