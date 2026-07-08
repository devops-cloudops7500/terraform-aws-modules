terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
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
      Service     = "alb"
    },
    var.additional_tags,
    var.tags
  )
}

module "alb" {
  source = "../../modules/alb"

  name                       = var.name
  internal                   = var.internal
  security_group_ids         = var.security_group_ids
  subnet_ids                 = var.subnet_ids
  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout
  vpc_id                     = var.vpc_id
  target_group_name          = var.target_group_name
  target_group_port          = var.target_group_port
  target_group_protocol      = var.target_group_protocol
  target_type                = var.target_type
  listener_port              = var.listener_port
  listener_protocol          = var.listener_protocol
  health_check               = var.health_check
  target_instance_ids        = var.target_instance_ids
  tags                       = local.default_tags
}
