resource "aws_security_group" "this" {
  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  for_each = {
    for idx, rule in var.ingress_rules : idx => rule
  }

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  cidr_ipv6         = try(each.value.cidr_ipv6, null)
  ip_protocol       = each.value.ip_protocol
  from_port         = try(each.value.from_port, null)
  to_port           = try(each.value.to_port, null)
  description       = try(each.value.description, null)
}

resource "aws_vpc_security_group_egress_rule" "this" {
  for_each = {
    for idx, rule in var.egress_rules : idx => rule
  }

  security_group_id = aws_security_group.this.id
  cidr_ipv4         = try(each.value.cidr_ipv4, null)
  cidr_ipv6         = try(each.value.cidr_ipv6, null)
  ip_protocol       = each.value.ip_protocol
  from_port         = try(each.value.from_port, null)
  to_port           = try(each.value.to_port, null)
  description       = try(each.value.description, null)
}
