module "instance_profile_role" {
  source = "../../modules/iam"

  role_name                         = var.instance_role_name
  role_description                  = "EC2 instance role"
  assume_role_principal_type        = "Service"
  assume_role_principal_identifiers = ["ec2.amazonaws.com"]
  aws_managed_policy_arns           = var.instance_role_policy_arns
  managed_policies                  = var.instance_role_custom_policies
  tags                              = var.tags
}

resource "aws_iam_instance_profile" "this" {
  name = var.instance_profile_name
  role = module.instance_profile_role.role_name
  tags = var.tags
}

module "security_group" {
  source = "../../modules/security-group"

  name          = var.security_group_name
  description   = var.security_group_description
  vpc_id        = var.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  tags          = var.tags
}

module "ec2" {
  source = "../../modules/ec2"

  name                        = var.instance_name
  ami_id                      = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  security_group_ids          = [module.security_group.security_group_id]
  iam_instance_profile        = aws_iam_instance_profile.this.name
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
  root_volume_size            = var.root_volume_size
  root_volume_type            = var.root_volume_type
  root_volume_kms_key_id      = var.root_volume_kms_key_id
  tags                        = var.tags
}

module "elastic_ip" {
  source = "../../modules/eip"
  count  = var.attach_eip ? 1 : 0

  name = "${var.instance_name}-eip"
  tags = var.tags
}

resource "aws_eip_association" "this" {
  count = var.attach_eip ? 1 : 0

  instance_id   = module.ec2.instance_id
  allocation_id = module.elastic_ip[0].allocation_id
}
