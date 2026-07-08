output "bucket_id" {
  description = "S3 bucket ID (name)."
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "S3 bucket ARN."
  value       = aws_s3_bucket.this.arn
}

output "bucket_regional_domain_name" {
  description = "Regional domain name of the bucket."
  value       = aws_s3_bucket.this.bucket_regional_domain_name
}

output "bucket_domain_name" {
  description = "Global bucket domain name."
  value       = aws_s3_bucket.this.bucket_domain_name
}

output "hosted_zone_id" {
  description = "Route53 hosted zone ID for S3 bucket endpoint."
  value       = aws_s3_bucket.this.hosted_zone_id
}

output "effective_encryption" {
  description = "Effective default encryption algorithm."
  value       = local.sse_algorithm
}
