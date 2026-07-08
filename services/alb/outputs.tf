output "alb_arn" {
  description = "ALB ARN."
  value       = module.alb.alb_arn
}

output "alb_dns_name" {
  description = "ALB DNS name."
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "ALB hosted zone ID."
  value       = module.alb.alb_zone_id
}

output "target_group_arn" {
  description = "Target group ARN."
  value       = module.alb.target_group_arn
}
