# Reusable S3 Module (Enterprise)

Production-ready reusable AWS S3 module focused on security, governance, and extensibility.

## Features

- Server-side encryption by default (SSE-S3 or optional SSE-KMS)
- S3 versioning support
- Public access block controls
- Bucket ownership controls
- Optional lifecycle rules
- Optional merged bucket policy
- Optional access logging
- Optional object lock support
- Optional CORS configuration
- Tag support

## Inputs

Key input categories:

- Bucket identity: `bucket_name`, `force_destroy`
- Security controls: `block_public_access`, `allow_tls_requests_only`, `kms_key_arn`
- Governance: `versioning_enabled`, `object_ownership`, object lock settings
- Data management: `lifecycle_rules`, `cors_rules`
- Auditability: `enable_access_logging`, `access_log_bucket_name`, `access_log_prefix`
- Policy: `bucket_policy_json`
- Metadata: `tags`

## Outputs

- `bucket_id`
- `bucket_arn`
- `bucket_domain_name`
- `bucket_regional_domain_name`
- `hosted_zone_id`
- `effective_encryption`

## Usage

```hcl
module "s3" {
  source = "../../modules/s3"

  bucket_name             = "org-prod-audit-logs-001"
  versioning_enabled      = true
  block_public_access     = true
  object_ownership        = "BucketOwnerEnforced"
  allow_tls_requests_only = true
  kms_key_arn             = "arn:aws:kms:us-east-1:123456789012:key/00000000-0000-0000-0000-000000000000"

  tags = {
    Project = "platform"
    Owner   = "cloud-team"
  }
}
```

## Security Notes

- Keep `block_public_access = true` unless there is an approved exception.
- Keep `allow_tls_requests_only = true`.
- Use customer-managed KMS for regulated workloads.
- Enable access logging to a centralized security log bucket.
- Avoid enabling `force_destroy` in production.
