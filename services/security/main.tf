module "kms" {
  source = "../../modules/kms"

  alias_name              = var.kms_alias_name
  description             = var.kms_description
  deletion_window_in_days = var.deletion_window_in_days
  enable_key_rotation     = var.enable_key_rotation
  policy_json             = var.kms_policy_json
  multi_region            = var.multi_region
  tags                    = var.tags
}

module "secret" {
  source = "../../modules/secrets-manager"

  name                    = var.secret_name
  description             = var.secret_description
  kms_key_id              = module.kms.key_arn
  recovery_window_in_days = var.secret_recovery_window_in_days
  secret_string           = var.secret_string
  tags                    = var.tags
}
