#
# Terraform module outputs
#

output "azure_network_security_group" {
  description = "Azure Network Security Groups"
  value       = azurerm_network_security_group.lz
}
