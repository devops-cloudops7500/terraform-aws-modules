output "vpc_id" {
  description = "VPC ID."
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "VPC ARN."
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "VPC CIDR block."
  value       = module.vpc.vpc_cidr_block
}

output "internet_gateway_id" {
  description = "Internet gateway ID, if created."
  value       = module.vpc.internet_gateway_id
}
