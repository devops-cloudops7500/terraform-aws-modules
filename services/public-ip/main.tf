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
      Service     = "public-ip"
    },
    var.additional_tags,
    var.tags
  )
}

module "public_ip" {
  source = "../../modules/public-ip"

  name        = var.name
  instance_id = var.instance_id
  tags        = local.default_tags
}
