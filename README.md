# terraform-aws-secretsmanager

This module creates a secret and allows assignment of permissions to IAM users or AWS Services.

## Usage

Clone as a new repository (using the GitHub CLI):

```bash
name="lz" # Example for naming as 'terraform-aws-lz'
PUBLIC_REPO=true
TERRAFORM_MODULE_PROVIDER="aws"
TERRAFORM_MODULE_NAME="terraform-${TERRAFORM_MODULE_PROVIDER}-${name}"
TEMPLATE_REPOSITORY="dustindortch/template-terraform-module"

if [ "${PWD##*/}" == "${TERRAFORM_MODULE_NAME}" ]; then
  cd ..
fi

gh repo create "${TERRAFORM_MODULE_NAME}" `[ "${PUBLIC_REPO}" == true ] && echo "--public" || echo "--private"` --template "${TEMPLATE_REPOSITORY}" --clone
```

Modify the name within this README.md file to match the name of the module you are creating (e.g. `terraform-aws-s3-bucket`).

Update the code within the Terraform configuration files (`main.tf`, `variables.tf`, `outputs.tf`) to match the desired functionality of the module.  The files created represent the recommended files for any Terraform configuration code.

## Establish variables/secrets for the repository

The repository should have the following established if initial publishing is desired:

TF_REGISTRY_ADDR: (variable) The address of the Terraform Registry (e.g. `registry.terraform.io` or `app.terraform.io`)
TF_REGISTRY_TOKEN: (secret) The token for the Terraform Registry.  If publishing to HCP Terraform or Terraform Enterprise, this should be a team token with privileges to publish modules.

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
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of secret. | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the principal resource for the module. (Required) | `string` | n/a | yes |
| <a name="input_permit_arns"></a> [permit\_arns](#input\_permit\_arns) | A list of ARNs to permit access to the principal resource. | `map(list(string))` | n/a | yes |
| <a name="input_recovery_window_in_days"></a> [recovery\_window\_in\_days](#input\_recovery\_window\_in\_days) | The number of days that AWS Secrets Manager waits before it can delete the secret. '0' means that the secret can be deleted immediately, or value must be between '7' and '30'. | `number` | `30` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the principal resource. | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->