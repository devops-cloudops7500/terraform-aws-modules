output "instance_id" {
  description = "EC2 instance ID."
  value       = module.ec2.instance_id
}

output "instance_arn" {
  description = "EC2 instance ARN."
  value       = module.ec2.instance_arn
}

output "private_ip" {
  description = "Private IP address."
  value       = module.ec2.private_ip
}

output "public_ip" {
  description = "Public IP address, if assigned."
  value       = module.ec2.public_ip
}
