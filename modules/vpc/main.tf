resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy
  tags                 = merge(var.tags, { Name = var.name })

  lifecycle {
    precondition {
      condition     = can(cidrhost(var.cidr_block, 0))
      error_message = "cidr_block must be a valid CIDR range."
    }
  }
}
