#
# SAS ESP Azure Key Vault
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_keyvault = {
  vault = {
    "sas-esp" = {
      name                            = "kv-spankki-afc-esp-dev"
      resource_group_name             = "rg-spankki-afc-esp-we-keyvault-dev"
      location                        = "westeurope"
      sku_name                        = "standard"
      tenant_id                       = "a652adc3-7bb3-4312-8eb0-6ab323f7d6cd"
      enabled_for_deployment          = false
      enabled_for_disk_encryption     = false
      enabled_for_template_deployment = false
      enable_rbac_authorization       = true
      purge_protection_enabled        = true
      soft_delete_retention_days      = 7
      network_acls = {
        bypass         = "AzureServices"
        default_action = "Allow"
      }
    },
    "sas-subscription" = {
      name                            = "kv-spankki-afc-we-dev"
      resource_group_name             = "rg-shared-prod"
      location                        = "westeurope"
      sku_name                        = "standard"
      tenant_id                       = "a652adc3-7bb3-4312-8eb0-6ab323f7d6cd"
      enabled_for_deployment          = false
      enabled_for_disk_encryption     = false
      enabled_for_template_deployment = false
      enable_rbac_authorization       = true
      purge_protection_enabled        = true
      soft_delete_retention_days      = 90
      network_acls = {
        bypass         = "AzureServices"
        default_action = "Allow"
      }
    }
  }
}
