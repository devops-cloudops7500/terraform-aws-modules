output "allocation_id" {
  description = "Elastic IP allocation ID."
  value       = module.public_ip.allocation_id
}

output "public_ip" {
  description = "Elastic public IPv4 address."
  value       = module.public_ip.public_ip
}

output "association_id" {
  description = "Elastic IP association ID, if associated."
  value       = module.public_ip.association_id
}
