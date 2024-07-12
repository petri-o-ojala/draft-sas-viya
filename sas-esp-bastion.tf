#
# SAS ESP Virtual Machine for Bastion
#

module "sas_esp_vm_bastion_keyvault" {
  source = "./azure-keyvault"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
    azure_key_vault      = module.sas_esp_keyvault.azure_key_vault
  }

  common   = var.sas_esp_common
  keyvault = var.sas_esp_vm_bastion_keyvault
}

module "sas_esp_vm_bastion_identity" {
  source = "./azure-authorization"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
  }

  common   = var.sas_esp_common
  identity = var.sas_esp_vm_bastion_identity
}

module "sas_esp_vm_bastion" {
  source = "./azure-virtual-machine"

  reference = {
    azure_resource_group          = module.sas_esp_resource_group.azure_resource_group
    azure_subnet                  = module.sas_esp_network.azure_subnet
    azure_log_analytics_workspace = module.sas_esp_log_analytics.azure_log_analytics_workspace
  }

  common = var.sas_esp_common
  vm     = var.sas_esp_vm_bastion

  depends_on = [
    module.sas_esp_acr_identity
  ]
}
