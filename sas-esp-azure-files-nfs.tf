#
# SAS ESP Azure Files NFS service
#

module "sas_esp_azure_files_nfs" {
  source = "./azure-storage"

  reference = {
    azure_resource_group          = module.sas_esp_resource_group.azure_resource_group
    azure_subnet                  = module.sas_esp_network.azure_subnet
    azure_private_dns_zone        = module.sas_esp_dns.azure_private_dns_zone
    azure_log_analytics_workspace = module.sas_esp_log_analytics.azure_log_analytics_workspace
  }

  common  = var.sas_esp_common
  storage = var.sas_esp_azure_files_nfs
}

module "sas_esp_azure_files_nfs_private_endpoint" {
  source = "./azure-network"

  reference = {
    azure_resource_group   = module.sas_esp_resource_group.azure_resource_group
    azure_private_dns_zone = module.sas_esp_dns.azure_private_dns_zone
    azure_subnet           = module.sas_esp_network.azure_subnet
    azure_resource_id = merge(
      {
        for resource_id, resource in module.sas_esp_azure_files_nfs.azure_storage_account : "storage-account-${resource_id}" => resource.id
      }
    )
  }

  common  = var.sas_esp_common
  network = var.sas_esp_azure_files_nfs_private_endpoint
}
