#
# Terraform module outputs
#

output "azure_dns_zone" {
  description = "Azure DNS Public Zones"
  value       = azurerm_dns_zone.lz
}

output "azure_private_dns_zone" {
  description = "Azure DNS Private Zones"
  value       = azurerm_private_dns_zone.lz
}
