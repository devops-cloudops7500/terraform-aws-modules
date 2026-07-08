module "s3" {
  source = "../../modules/s3"

  bucket_name        = var.bucket_name
  versioning_enabled = var.versioning_enabled
  force_destroy      = var.force_destroy
  object_ownership   = var.object_ownership
  kms_key_arn        = var.kms_key_arn
  enforce_tls        = var.enforce_tls
  tags               = var.tags
}
