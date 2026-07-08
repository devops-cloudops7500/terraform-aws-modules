resource "aws_subnet" "this" {
  for_each = {
    for subnet in var.subnets : subnet.name => subnet
  }

  vpc_id                  = var.vpc_id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge(
    var.tags,
    each.value.tags,
    {
      Name = each.value.name
    }
  )
}
