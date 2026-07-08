module "vpc" {
  source = "../../modules/vpc"

  name                 = var.vpc_name
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  tags                 = var.tags
}

module "igw" {
  source = "../../modules/igw"

  name   = "${var.vpc_name}-igw"
  vpc_id = module.vpc.vpc_id
  tags   = var.tags
}

module "public_subnets" {
  source = "../../modules/subnet"

  for_each = var.public_subnets

  name                    = each.value.name
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
  tags                    = var.tags
}

module "private_subnets" {
  source = "../../modules/subnet"

  for_each = var.private_subnets

  name                    = each.value.name
  vpc_id                  = module.vpc.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false
  tags                    = var.tags
}

module "nat_eip" {
  source = "../../modules/eip"

  name = "${var.vpc_name}-nat-eip"
  tags = var.tags
}

module "nat_gateway" {
  source = "../../modules/nat"

  name          = "${var.vpc_name}-nat"
  subnet_id     = values(module.public_subnets)[0].subnet_id
  allocation_id = module.nat_eip.allocation_id
  tags          = var.tags
}

module "public_route_table" {
  source = "../../modules/route-table"

  name   = "${var.vpc_name}-public-rt"
  vpc_id = module.vpc.vpc_id
  routes = [
    {
      cidr_block                = "0.0.0.0/0"
      ipv6_cidr_block           = null
      gateway_id                = module.igw.internet_gateway_id
      nat_gateway_id            = null
      transit_gateway_id        = null
      egress_only_gateway_id    = null
      network_interface_id      = null
      vpc_peering_connection_id = null
    }
  ]
  subnet_ids = [for s in values(module.public_subnets) : s.subnet_id]
  tags       = var.tags
}

module "private_route_table" {
  source = "../../modules/route-table"

  name   = "${var.vpc_name}-private-rt"
  vpc_id = module.vpc.vpc_id
  routes = [
    {
      cidr_block                = "0.0.0.0/0"
      ipv6_cidr_block           = null
      gateway_id                = null
      nat_gateway_id            = module.nat_gateway.nat_gateway_id
      transit_gateway_id        = null
      egress_only_gateway_id    = null
      network_interface_id      = null
      vpc_peering_connection_id = null
    }
  ]
  subnet_ids = [for s in values(module.private_subnets) : s.subnet_id]
  tags       = var.tags
}
