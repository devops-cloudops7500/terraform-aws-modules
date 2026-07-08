output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs."
  value       = [for s in values(module.public_subnets) : s.subnet_id]
}

output "private_subnet_ids" {
  description = "Private subnet IDs."
  value       = [for s in values(module.private_subnets) : s.subnet_id]
}

output "nat_gateway_id" {
  description = "NAT gateway ID."
  value       = module.nat_gateway.nat_gateway_id
}
