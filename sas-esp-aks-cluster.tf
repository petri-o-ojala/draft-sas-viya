#
# SAS ESP AKS Cluster
#

module "sas_esp_aks_identity" {
  source = "./azure-authorization"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
  }

  common   = var.sas_esp_common
  identity = var.sas_esp_aks_identity
}


module "sas_esp_aks" {
  source = "./azure-kubernetes-service"

  reference = {
    azure_resource_group          = module.sas_esp_resource_group.azure_resource_group
    azure_subnet                  = module.sas_esp_network.azure_subnet
    azure_private_dns_zone        = module.sas_esp_dns.azure_private_dns_zone
    azure_log_analytics_workspace = module.sas_esp_log_analytics.azure_log_analytics_workspace
  }

  common = var.sas_esp_common
  aks    = var.sas_esp_aks
}

module "sas_esp_aks_private_endpoint" {
  source = "./azure-network"

  reference = {
    azure_resource_group   = module.sas_esp_resource_group.azure_resource_group
    azure_private_dns_zone = module.sas_esp_dns.azure_private_dns_zone
    azure_subnet           = module.sas_esp_network.azure_subnet
    azure_resource_id = merge(
      {
        for resource_id, resource in module.sas_esp_aks.azure_kubernetes_cluster : "aks-cluster-${resource_id}" => resource.id
      }
  ) }

  common  = var.sas_esp_common
  network = var.sas_esp_aks_private_endpoint
}
