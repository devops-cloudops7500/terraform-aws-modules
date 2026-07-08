output "subnet_ids" {
  description = "All created subnet IDs."
  value       = values(aws_subnet.this)[*].id
}

output "subnet_ids_by_name" {
  description = "Subnet IDs keyed by subnet name."
  value       = { for name, subnet in aws_subnet.this : name => subnet.id }
}

output "public_subnet_ids" {
  description = "Subnet IDs where map_public_ip_on_launch is true."
  value = [
    for subnet in values(aws_subnet.this) : subnet.id
    if subnet.map_public_ip_on_launch
  ]
}
