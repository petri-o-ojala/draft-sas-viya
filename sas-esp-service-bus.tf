#
# SAS ESP Azure Container Registry
#

module "sas_esp_servicebus" {
  source = "./azure-messaging"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
  }

  common     = var.sas_esp_common
  servicebus = var.sas_esp_servicebus
}
