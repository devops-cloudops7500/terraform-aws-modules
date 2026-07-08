output "instance_id" {
  description = "EC2 instance ID."
  value       = module.ec2.instance_id
}

output "security_group_id" {
  description = "Instance security group ID."
  value       = module.security_group.security_group_id
}

output "instance_role_arn" {
  description = "IAM role ARN for EC2."
  value       = module.instance_profile_role.role_arn
}

output "elastic_ip" {
  description = "Elastic IP, when enabled."
  value       = var.attach_eip ? module.elastic_ip[0].public_ip : null
}
