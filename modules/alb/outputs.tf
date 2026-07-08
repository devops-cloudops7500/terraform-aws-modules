output "alb_arn" {
  description = "ALB ARN."
  value       = aws_lb.this.arn_suffix
}

output "alb_dns_name" {
  description = "ALB DNS name."
  value       = aws_lb.this.dns_name
}

output "target_group_arns" {
  description = "Target group ARNs."
  value       = { for k, v in aws_lb_target_group.this : k => v.arn }
}
