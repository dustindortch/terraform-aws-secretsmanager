terraform {
  required_version = "~> 1.8"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    version = "~> 5.0" }
  }
}

data "aws_iam_policy_document" "policy" {
  dynamic "statement" {
    for_each = length(var.admin_principals) > 0 ? [1] : []

    content {
      sid       = "AllowAdmin"
      actions   = ["secretsmanager:*"]
      effect    = "Allow"
      resources = [aws_secretsmanager_secret.secret.arn]
      principals {
        identifiers = [
          for i in var.admin_principals : i
          if contains(["iam", "sts"], provider::aws::arn_parse(i).service)
        ]
        type = "AWS"
      }

      principals {
        identifiers = [
          for i in var.admin_principals : format("%s.amazonaws.com", provider::aws::arn_parse(i).service)
          if contains(["lambda"], provider::aws::arn_parse(i).service)
        ]
        type = "Service"
      }
    }
  }
  dynamic "statement" {
    for_each = length(var.read_principals) > 0 ? [1] : []

    content {
      sid       = "AllowRead"
      actions   = ["secretsmanager:GetSecretValue", "secretsmanager:BatchGetSecretValue", "secretsmanager:ListSecrets", "secretsmanager:DescribeSecret"]
      effect    = "Allow"
      resources = [aws_secretsmanager_secret.secret.arn]

      principals {
        identifiers = [
          for i in var.read_principals : i
          if contains(["iam", "sts"], provider::aws::arn_parse(i).service)
        ]
        type = "AWS"
      }

      principals {
        identifiers = [
          for i in var.read_principals : format("%s.amazonaws.com", provider::aws::arn_parse(i).service)
          if contains(["lambda"], provider::aws::arn_parse(i).service)
        ]
        type = "Service"
      }
    }
  }

  dynamic "statement" {
    for_each = length(var.readwrite_principals) > 0 ? [1] : []

    content {
      sid       = "AllowReadWrite"
      actions   = ["secretsmanager:GetSecretValue", "secretsmanager:BatchGetSecretValue", "secretsmanager:ListSecrets", "secretsmanager:DescribeSecret", "secretsmanager:PutSecretValue", "secretsmanager:UpdateSecretVersionStage"]
      effect    = "Allow"
      resources = [aws_secretsmanager_secret.secret.arn]

      principals {

        identifiers = [
          for i in var.readwrite_principals : i
          if contains(["iam", "sts"], provider::aws::arn_parse(i).service)
        ]
        type = "AWS"
      }

      principals {
        identifiers = [
          for i in var.readwrite_principals : format("%s.amazonaws.com", provider::aws::arn_parse(i).service)
          if contains(["lambda"], provider::aws::arn_parse(i).service)
        ]
        type = "Service"
      }
    }
  }
}

resource "aws_secretsmanager_secret" "secret" {
  name                    = var.name
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days

  tags = var.tags
}

resource "aws_secretsmanager_secret_policy" "policy" {
  secret_arn = aws_secretsmanager_secret.secret.arn
  policy     = data.aws_iam_policy_document.policy.json
  # block_public_policy = true
}
