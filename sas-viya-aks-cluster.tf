#
# SAS Viya AKS Cluster
#

module "sas_viya_aks" {
  source = "./azure-kubernetes-service"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common = var.sas_viya_common
  aks    = var.sas_viya_aks
}
