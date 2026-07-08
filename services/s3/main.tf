terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "remote" {}
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.default_tags
  }
}

locals {
  default_tags = merge(
    {
      ManagedBy   = "Terraform"
      Environment = var.environment
      Project     = var.project_name
      Owner       = var.owner
      CostCenter  = var.cost_center
      DataClass   = var.data_classification
      Service     = "s3"
    },
    var.additional_tags,
    var.tags
  )
}

module "s3" {
  source = "../../modules/s3"

  bucket_name             = var.bucket_name
  force_destroy           = var.force_destroy
  versioning_enabled      = var.versioning_enabled
  block_public_access     = var.block_public_access
  object_ownership        = var.object_ownership
  kms_key_arn             = var.kms_key_arn
  allow_tls_requests_only = var.allow_tls_requests_only
  bucket_policy_json      = var.bucket_policy_json
  enable_access_logging   = var.enable_access_logging
  access_log_bucket_name  = var.access_log_bucket_name
  access_log_prefix       = var.access_log_prefix
  lifecycle_rules         = var.lifecycle_rules
  cors_rules              = var.cors_rules
  object_lock_enabled     = var.object_lock_enabled
  object_lock_mode        = var.object_lock_mode
  object_lock_days        = var.object_lock_days
  object_lock_years       = var.object_lock_years
  tags                    = local.default_tags
}
