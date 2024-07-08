#
# SAS ESP Azure Container Registry
#

module "sas_esp_acr_identity" {
  source = "./azure-authorization"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
  }

  common   = var.sas_esp_common
  identity = var.sas_esp_acr_identity
}

module "sas_esp_acr" {
  source = "./azure-container-registry"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
  }

  common             = var.sas_esp_common
  container_registry = var.sas_esp_acr

  depends_on = [
    module.sas_esp_acr_identity
  ]
}
