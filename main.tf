# main.tf

# Modify Terraform version constraints and required_providers block
terraform {
  required_version = "~> 1.8"
  required_providers {
    local = {
      source = "hashicorp/local"
    }
  }
}

# Do not include provider blocks

# Add configuration code
