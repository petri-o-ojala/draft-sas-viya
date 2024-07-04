#
# SAS Viya Azure Container Registry
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_viya_acr = {
  registry = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
    "sas-viya" = {
      resource_group_name           = "rg-spankki-afc-esp-we-acr-dev"
      location                      = "westeurope"
      name                          = "spankkisasdev"
      sku                           = "Premium"
      admin_enabled                 = true
      public_network_access_enabled = false
      identity = {
        type = "SystemAssigned"
      }
    }
  }
}
