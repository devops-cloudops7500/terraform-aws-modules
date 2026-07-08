output "kms_key_arn" {
  description = "KMS key ARN."
  value       = module.kms.key_arn
}

output "secret_arn" {
  description = "Secret ARN."
  value       = module.secret.secret_arn
}
