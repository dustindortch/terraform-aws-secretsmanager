# template-terraform-module

This repository is a template for creating a new Terraform module.

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

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the principal resource for the module. (Required) | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_name"></a> [name](#output\_name) | The `name` of the principal resource for the module. |
<!-- END_TF_DOCS -->