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
      Service     = "vpc"
    },
    var.additional_tags,
    var.tags
  )
}

module "vpc" {
  source = "../../modules/vpc"

  name                    = var.name
  cidr_block              = var.cidr_block
  enable_dns_support      = var.enable_dns_support
  enable_dns_hostnames    = var.enable_dns_hostnames
  create_internet_gateway = var.create_internet_gateway
  tags                    = local.default_tags
}
