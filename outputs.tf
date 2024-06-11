# outputs.tf

# Outputs are the interface for the module to accept returned values in the calling root module.

output "name" {
  description = "The `name` of the principal resource for the module."
  value       = var.name
}
