resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = var.security_group_ids
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  user_data                   = var.user_data

  dynamic "root_block_device" {
    for_each = var.root_block_device == null ? [] : [var.root_block_device]

    content {
      volume_type           = try(root_block_device.value.volume_type, null)
      volume_size           = try(root_block_device.value.volume_size, null)
      encrypted             = try(root_block_device.value.encrypted, null)
      delete_on_termination = try(root_block_device.value.delete_on_termination, null)
      kms_key_id            = try(root_block_device.value.kms_key_id, null)
    }
  }

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}
