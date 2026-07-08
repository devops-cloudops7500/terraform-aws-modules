output "role_arn" {
  description = "IAM role ARN."
  value       = aws_iam_role.this.arn
}

output "role_name" {
  description = "IAM role name."
  value       = aws_iam_role.this.name
}

output "custom_policy_arns" {
  description = "Created custom policy ARNs."
  value       = [for p in values(aws_iam_policy.managed) : p.arn]
}
