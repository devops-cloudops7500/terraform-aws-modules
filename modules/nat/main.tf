resource "aws_nat_gateway" "this" {
  allocation_id = var.allocation_id
  subnet_id     = var.subnet_id
  tags          = merge(var.tags, { Name = var.name })

  lifecycle {
    precondition {
      condition     = length(trimspace(var.allocation_id)) > 0
      error_message = "allocation_id is required for NAT gateway."
    }
  }
}
