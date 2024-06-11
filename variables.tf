# variables.tf

# Variables are the interface for the calling root module to pass values into the module.

variable "name" {
  description = "Name of the principal resource for the module. (Required)"
  type        = string

  # Include variable validation blocks, as needed (recommended)
  validation {
    condition     = length(var.name) > 0
    error_message = "The `name` variable must be a non-empty string."
  }

  validation {
    condition     = length(var.name) <= 15
    error_message = "The `name` variable must be between 1 and 15 characters in length."
  }
}
