resource "aws_lb" "this" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = var.security_group_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = var.enable_deletion_protection
  idle_timeout               = var.idle_timeout

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}

resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  target_type = var.target_type
  vpc_id      = var.vpc_id

  health_check {
    enabled             = var.health_check.enabled
    interval            = var.health_check.interval
    path                = var.health_check.path
    healthy_threshold   = var.health_check.healthy_threshold
    unhealthy_threshold = var.health_check.unhealthy_threshold
    timeout             = var.health_check.timeout
    matcher             = var.health_check.matcher
    protocol            = var.health_check.protocol
  }

  tags = merge(
    var.tags,
    {
      Name = var.target_group_name
    }
  )
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

resource "aws_lb_target_group_attachment" "instance" {
  for_each = toset(var.target_instance_ids)

  target_group_arn = aws_lb_target_group.this.arn
  target_id        = each.value
  port             = var.target_group_port
}
