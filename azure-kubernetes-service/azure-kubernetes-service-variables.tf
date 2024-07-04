#
# Azure Kubernetes Service
#

variable "aks" {
  description = "Azure Kubernetes Service"
  type = object({

  })
  default = {}
}

locals {
  aks = var.aks

  #
  # Principal IDs
  #
  azure_principal_id = merge(
    local.entra_id_alias,
    {
      for resource_id, principal_id in local.azure_resource_principal_id : resource_id => principal_id
    }
  )

  #
  # Azure Kubernetes Service
  #
  azure_kubernetes_cluster = flatten([
    for cluster_id, cluster in coalesce(try(local.aks.cluster, null), {}) : merge(
      cluster,
      {
        resource_index = join("_", [cluster_id])
      }
    )
  ])
}
