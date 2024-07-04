#
# SAS Viya Azure Container Registry
#

module "sas_viya_servicebus" {
  source = "./azure-messaging"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common     = var.sas_viya_common
  servicebus = var.sas_viya_servicebus
}
