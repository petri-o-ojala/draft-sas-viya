#
# Terraform module outputs
#

output "azure_resource_group" {
  description = "Azure Resource Groups"
  value       = azurerm_resource_group.lz
}
