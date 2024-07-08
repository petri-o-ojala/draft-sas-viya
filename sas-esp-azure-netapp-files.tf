#
# SAS ESP Azure NetApp Files
#

module "sas_esp_anf" {
  source = "./azure-netapp-files"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
    azure_subnet         = module.sas_esp_network.azure_subnet
  }

  common = var.sas_esp_common
  anf    = var.sas_esp_anf
}
