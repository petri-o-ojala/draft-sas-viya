#
# Azure Keyvault content
#

locals {
  #
  # Azure Keyvault secrets
  #
  azure_keyvault_secret = flatten([
    for keyvault_id, keyvault in coalesce(try(var.confluent.datasource.keyvault, null), {}) : [
      for secret in coalesce(keyvault.secret, []) : merge(
        {
          name           = secret
          key_vault_id   = lookup(local.azure_key_vault, keyvault_id, null) == null ? keyvault.keyvault_id : local.azure_key_vault[keyvault_id].id
          resource_index = join(":", [keyvault_id, secret])
        }
      )
    ]
  ])
}

output "azure_keyvault_secret" {
  value = local.azure_keyvault_secret
}
