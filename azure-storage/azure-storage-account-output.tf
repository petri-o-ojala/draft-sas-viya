#
# Terraform module outputs
#

output "azure_storage_account" {
  description = "Azure Storage Accounts"
  value       = azurerm_storage_account.lz
}

output "azure_storage_container" {
  description = "Azure Storage Account Containers"
  value       = azurerm_storage_container.lz
}
