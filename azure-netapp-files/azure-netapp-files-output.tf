#
# Terraform module outputs
#

output "azure_netapp_account" {
  description = "Azure NetApp Files Accounts"
  value       = azurerm_netapp_account.lz
}

output "azure_netapp_pool" {
  description = "Azure NetApp Files Pools"
  value       = azurerm_netapp_pool.lz
}

output "azure_netapp_volume" {
  description = "Azure NetApp Files Volumes"
  value       = azurerm_netapp_volume.lz
}
