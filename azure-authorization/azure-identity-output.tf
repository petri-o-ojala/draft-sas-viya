#
# Terraform module outputs
#

output "azure_user_assigned_identity" {
  description = "Azure User Assigned Identities"
  value       = azurerm_user_assigned_identity.lz
}

output "azure_federated_identity_credential" {
  description = "Azure Federated Identity Credentials"
  value       = azurerm_federated_identity_credential.lz
}
