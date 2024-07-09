#
# Terraform module outputs
#

output "azure_key_vault" {
  description = "Azure Key vaults"
  value       = azurerm_key_vault.lz
}
