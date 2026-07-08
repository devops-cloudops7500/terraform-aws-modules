resource "aws_sqs_queue" "this" {
  name                              = var.name
  kms_master_key_id                 = var.kms_master_key_id
  kms_data_key_reuse_period_seconds = var.kms_data_key_reuse_period_seconds
  visibility_timeout_seconds        = var.visibility_timeout_seconds
  message_retention_seconds         = var.message_retention_seconds
  receive_wait_time_seconds         = var.receive_wait_time_seconds
  delay_seconds                     = var.delay_seconds
  max_message_size                  = var.max_message_size
  tags                              = merge(var.tags, { Name = var.name })
}
