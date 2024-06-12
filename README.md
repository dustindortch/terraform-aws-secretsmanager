# terraform-aws-secretsmanager

This module creates a secret and allows assignment of permissions to IAM users or AWS Services.

## Usage

module "secret" {
  source = "dustindortch/secretsmanager/aws"

  name                    = "my-secret-new"
  admin_principals        = [data.aws_caller_identity.current.arn]
  read_principals         = [module.lambda.lambda.arn]
  recovery_window_in_days = 0
}

## Branching Strategy

The branching strategy for Terraform modules essentially follows 'Release Flow' and follows [Semantic Versioning 2.0](https://semver.org) practices:

1. New features: create a feature branch (e.g. 'feature/<issue_number>-<description>') from `main` and merge back into `main` with a pull request and select the appropriate label for the change (i.e. "major", "minor", "alpha", "beta", "rc", or "no-release").
2. Bug fixes: create a hotfix branch (e.g. 'hotfix/<issue_number>-<description>') from `main` and merge back into `main` with a pull request and select the appropriate label for the change (i.e. "patch").
3. Releases: a release tag is created from `main` with the appropriate version number (e.g. `v1.0.0`) and are automatically published to the registry.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_secretsmanager_secret.secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_policy) | resource |
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admin_principals"></a> [admin\_principals](#input\_admin\_principals) | A list of ARNs of IAM principals that can access the secret. | `list(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of secret. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the principal resource for the module. (Required) | `string` | n/a | yes |
| <a name="input_read_principals"></a> [read\_principals](#input\_read\_principals) | A list of ARNs of IAM principals that can access the secret. | `list(string)` | `[]` | no |
| <a name="input_readwrite_principals"></a> [readwrite\_principals](#input\_readwrite\_principals) | A list of ARNs of IAM principals that can access the secret. | `list(string)` | `[]` | no |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | The number of days that AWS Secrets Manager waits before it can delete the secret. '0' means that the secret can be deleted immediately, or value must be between '7' and '30'. | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the principal resource. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_json_document"></a> [json\_document](#output\_json\_document) | n/a |
<!-- END_TF_DOCS -->