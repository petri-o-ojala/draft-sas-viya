#
# Terraform module outputs
#

output "azure_container_registry" {
  description = "Azure Container Registries"
  value       = azurerm_container_registry.lz
}
