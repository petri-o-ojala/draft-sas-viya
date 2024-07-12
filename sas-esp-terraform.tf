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

module "sas_esp_terraform_state_storage_private_endpoint" {
  source = "./azure-network"

  reference = {
    azure_resource_group   = module.sas_esp_resource_group.azure_resource_group
    azure_private_dns_zone = module.sas_esp_dns.azure_private_dns_zone
    azure_subnet           = module.sas_esp_network.azure_subnet
    azure_resource_id = merge(
      {
        for resource_id, resource in module.sas_esp_terraform_state_storage.azure_storage_account : "storage-account-${resource_id}" => resource.id
      }
    )
  }

  common  = var.sas_esp_common
  network = lookup(var.sas_esp_tietoevry_azure_terraform, "storage_private_endpoint", {})
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
