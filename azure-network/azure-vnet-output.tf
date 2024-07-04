#
# Terraform module outputs
#

output "azure_virtual_network" {
  description = "Azure VNet Networks"
  value       = azurerm_virtual_network.lz
}

output "azure_subnet" {
  description = "Azure VNet Subnets"
  value       = azurerm_subnet.lz
}

output "azure_public_ip" {
  description = "Azure Public IPs"
  value       = azurerm_public_ip.lz
}
