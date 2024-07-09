#
# SAS ESP Azure Container Registry
#


module "sas_esp_terraform_resource_group" {
  source = "./azure-resource-group"

  resource_group = lookup(var.sas_esp_tietoevry_azure_terraform, "resource_group", {})
}

module "sas_esp_terraform_state_storage" {
  source = "./azure-storage"

  entra_id = var.spankki_entra_id
  storage  = lookup(var.sas_esp_tietoevry_azure_terraform, "storage", {})

  depends_on = [
    module.sas_esp_terraform_resource_group
  ]
}

module "sas_esp_terraform_keyvault" {
  source = "./azure-keyvault"

  entra_id = var.spankki_entra_id
  keyvault = lookup(var.sas_esp_tietoevry_azure_terraform, "keyvault", {})

  depends_on = [
    module.sas_esp_terraform_resource_group
  ]
}

module "sas_esp_terraform_identity" {
  source = "./azure-authorization"

  reference = {
    azure_resource_group = module.sas_esp_terraform_resource_group.azure_resource_group
  }

  identity = lookup(var.sas_esp_tietoevry_azure_terraform, "identity", {})
  role     = lookup(var.sas_esp_tietoevry_azure_terraform, "role", {})
}
