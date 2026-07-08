output "subnet_ids" {
  description = "All created subnet IDs."
  value       = module.subnet.subnet_ids
}

output "subnet_ids_by_name" {
  description = "Subnet IDs keyed by subnet name."
  value       = module.subnet.subnet_ids_by_name
}

output "public_subnet_ids" {
  description = "Subnet IDs where map_public_ip_on_launch is true."
  value       = module.subnet.public_subnet_ids
}
