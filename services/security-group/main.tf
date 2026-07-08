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
      Service     = "security-group"
    },
    var.additional_tags,
    var.tags
  )
}

module "security_group" {
  source = "../../modules/security-group"

  name          = var.name
  description   = var.description
  vpc_id        = var.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  tags          = local.default_tags
}
