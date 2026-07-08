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
      Service     = "ec2"
    },
    var.additional_tags,
    var.tags
  )
}

module "ec2" {
  source = "../../modules/ec2"

  name                        = var.name
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_group_ids          = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data
  root_block_device           = var.root_block_device
  tags                        = local.default_tags
}
