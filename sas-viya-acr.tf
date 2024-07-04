#
# SAS Viya Azure Container Registry
#

module "sas_viya_acr" {
  source = "./azure-container-registry"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common             = var.sas_viya_common
  container_registry = var.sas_viya_acr
}
