module "sns" {
  source = "../../modules/sns"

  name              = var.sns_topic_name
  kms_master_key_id = var.sns_kms_master_key_id
  subscriptions     = var.sns_subscriptions
  tags              = var.tags
}

module "sqs" {
  source = "../../modules/sqs"

  name                              = var.sqs_queue_name
  kms_master_key_id                 = var.sqs_kms_master_key_id
  kms_data_key_reuse_period_seconds = var.sqs_kms_data_key_reuse_period_seconds
  visibility_timeout_seconds        = var.sqs_visibility_timeout_seconds
  message_retention_seconds         = var.sqs_message_retention_seconds
  receive_wait_time_seconds         = var.sqs_receive_wait_time_seconds
  delay_seconds                     = var.sqs_delay_seconds
  max_message_size                  = var.sqs_max_message_size
  tags                              = var.tags
}

resource "aws_sns_topic_subscription" "sqs_subscription" {
  count = var.subscribe_sqs_to_sns ? 1 : 0

  topic_arn = module.sns.topic_arn
  protocol  = "sqs"
  endpoint  = module.sqs.queue_arn
}
