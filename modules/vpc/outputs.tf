output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "VPC ARN."
  value       = aws_vpc.this.arn
}

output "vpc_cidr_block" {
  description = "VPC CIDR block."
  value       = aws_vpc.this.cidr_block
}

output "internet_gateway_id" {
  description = "Internet gateway ID, if created."
  value       = one(aws_internet_gateway.this[*].id)
}
