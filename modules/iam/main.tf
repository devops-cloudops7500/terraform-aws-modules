data "aws_iam_policy_document" "assume_role" {
  statement {
    sid     = "AssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = var.assume_role_principal_type
      identifiers = var.assume_role_principal_identifiers
    }
  }
}

resource "aws_iam_role" "this" {
  name                 = var.role_name
  description          = var.role_description
  assume_role_policy   = data.aws_iam_policy_document.assume_role.json
  max_session_duration = var.max_session_duration
  path                 = var.path
  tags                 = merge(var.tags, { Name = var.role_name })
}

resource "aws_iam_policy" "managed" {
  for_each = var.managed_policies

  name        = each.key
  description = each.value.description
  policy      = each.value.policy_json
  path        = var.path
  tags        = var.tags
}

resource "aws_iam_role_policy_attachment" "aws_managed" {
  for_each = toset(var.aws_managed_policy_arns)

  role       = aws_iam_role.this.name
  policy_arn = each.value
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = aws_iam_policy.managed

  role       = aws_iam_role.this.name
  policy_arn = each.value.arn
}
