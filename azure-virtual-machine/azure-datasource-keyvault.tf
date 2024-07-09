#
# Azure Keyvault content
#

locals {
  azurerm_key_vault_secret = data.azurerm_key_vault_secret.lz
}

data "azurerm_key_vault_secret" "lz" {
  for_each = {
    for secret in local.azure_keyvault_secret : secret.resource_index => secret
  }

  name         = each.value.name
  key_vault_id = each.value.key_vault_id
}
