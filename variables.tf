variable "name" {
  description = "Name of the principal resource for the module. (Required)"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9/_+=@-]+$", var.name))
    error_message = "The `name` variable must be a non-empty string."
  }
}

variable "description" {
  default     = ""
  description = "Description of secret."
  type        = string
}

variable "admin_principals" {
  default     = []
  description = "A list of ARNs of IAM principals that can access the secret."
  type        = list(string)

  validation {
    condition     = alltrue([for i in var.admin_principals : can(provider::aws::arn_parse(i))])
    error_message = "The `admin_principals` values must be a list of valid ARNs."
  }
}

variable "read_principals" {
  default     = []
  description = "A list of ARNs of IAM principals that can access the secret."
  type        = list(string)

  validation {
    condition     = alltrue([for i in var.read_principals : can(provider::aws::arn_parse(i))])
    error_message = "The `read_principals` values must be a list of valid ARNs."
  }
}

variable "readwrite_principals" {
  default     = []
  description = "A list of ARNs of IAM principals that can access the secret."
  type        = list(string)

  validation {
    condition     = alltrue([for i in var.readwrite_principals : can(provider::aws::arn_parse(i))])
    error_message = "The `readwrite_principals` values must be a list of valid ARNs."
  }
}

variable "recovery_window_in_days" {
  default     = 30
  description = "The number of days that AWS Secrets Manager waits before it can delete the secret. '0' means that the secret can be deleted immediately, or value must be between '7' and '30'."
  type        = number

  validation {
    condition     = var.recovery_window_in_days == 0 || var.recovery_window_in_days >= 7 && var.recovery_window_in_days <= 30
    error_message = "The `recovery_window_in_days` variable must be 0, or between 7 and 30."
  }
}

variable "tags" {
  default     = {}
  description = "A map of tags to assign to the principal resource."
  type        = map(string)
}
