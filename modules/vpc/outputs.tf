output "vpc_id" {
  description = "VPC ID."
  value       = aws_vpc.this.id
}

output "vpc_arn" {
  description = "VPC ARN."
  value       = aws_vpc.this.arn
}

output "default_route_table_id" {
  description = "Default route table ID."
  value       = aws_vpc.this.default_route_table_id
}
