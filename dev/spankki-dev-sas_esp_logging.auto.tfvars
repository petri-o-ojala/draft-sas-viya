#
# SAS ESP Azure configuration for Log Analytics
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_log_analytics = {
  workspace = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace
    "logs" = {
      name                            = "law-spankki-afc-esp-dev"
      location                        = "westeurope"
      resource_group_name             = "rg-spankki-afc-esp-we-common-dev"
      sku                             = "PerGB2018"
      retention_in_days               = 730
      allow_resource_only_permissions = true
      internet_ingestion_enabled      = false
      internet_query_enabled          = false
    }
  }
}
