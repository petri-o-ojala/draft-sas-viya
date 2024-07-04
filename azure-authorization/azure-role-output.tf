#
# Terraform module outputs
#

output "azure_role_definition" {
  description = "Azure Role Definitions"
  value       = azurerm_role_definition.lz
}
