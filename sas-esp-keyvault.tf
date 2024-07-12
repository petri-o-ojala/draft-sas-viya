#
# SAS ESP Azure Container Registry
#

module "sas_esp_keyvault" {
  source = "./azure-keyvault"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
  }

  common   = var.sas_esp_common
  keyvault = var.sas_esp_keyvault
}
