#
# Azure Kubernetes Service
#

variable "aks" {
  description = "Azure Kubernetes Service"
  type = object({
    node_pool = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool
      name                          = string
      kubernetes_cluster_id         = string
      vm_size                       = string
      capacity_reservation_group_id = optional(string)
      custom_ca_trust_enabled       = optional(bool)
      enable_auto_scaling           = optional(bool)
      enable_host_encryption        = optional(bool)
      enable_node_public_ip         = optional(bool)
      gpu_instance                  = optional(string)
      host_group_id                 = optional(string)
      fips_enabled                  = optional(bool)
      kubelet_disk_type             = optional(string)
      max_pods                      = optional(number)
      message_of_the_day            = optional(string)
      node_public_ip_prefix_id      = optional(string)
      node_labels                   = optional(map(string))
      orchestrator_version          = optional(string)
      os_disk_size_gb               = optional(number)
      os_disk_type                  = optional(string)
      os_sku                        = optional(string)
      pod_subnet_id                 = optional(string)
      proximity_placement_group_id  = optional(string)
      scale_down_mode               = optional(string)
      snapshot_id                   = optional(string)
      tags                          = optional(map(string))
      ultra_ssd_enabled             = optional(bool)
      vnet_subnet_id                = optional(string)
      workload_runtime              = optional(string)
      zones                         = optional(list(string))
    })))
    cluster = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
      name                                = string
      resource_group_name                 = string
      location                            = string
      tags                                = optional(map(string))
      dns_prefix                          = optional(string)
      dns_prefix_private_cluster          = optional(string)
      automatic_channel_upgrade           = optional(string)
      azure_policy_enabled                = optional(bool)
      cost_analysis_enabled               = optional(bool)
      custom_ca_trust_certificates_base64 = optional(list(string))
      disk_encryption_set_id              = optional(string)
      http_application_routing_enabled    = optional(bool)
      image_cleaner_enabled               = optional(bool)
      image_cleaner_interval_hours        = optional(number)
      kubernetes_version                  = optional(string)
      local_account_disabled              = optional(bool)
      node_os_channel_upgrade             = optional(string)
      node_resource_group                 = optional(string)
      oidc_issuer_enabled                 = optional(bool)
      open_service_mesh_enabled           = optional(bool)
      private_cluster_enabled             = optional(bool)
      private_dns_zone_id                 = optional(string)
      private_cluster_public_fqdn_enabled = optional(bool)
      workload_identity_enabled           = optional(bool)
      public_network_access_enabled       = optional(bool)
      role_based_access_control_enabled   = optional(bool)
      run_command_enabled                 = optional(bool)
      sku_tier                            = optional(string)
      support_plan                        = optional(string)
      default_node_pool = object({
        name                          = string
        vm_size                       = string
        capacity_reservation_group_id = optional(string)
        custom_ca_trust_enabled       = optional(bool)
        enable_auto_scaling           = optional(bool)
        enable_host_encryption        = optional(bool)
        enable_node_public_ip         = optional(bool)
        gpu_instance                  = optional(string)
        host_group_id                 = optional(string)
        fips_enabled                  = optional(bool)
        kubelet_disk_type             = optional(string)
        max_pods                      = optional(number)
        message_of_the_day            = optional(string)
        node_public_ip_prefix_id      = optional(string)
        node_labels                   = optional(map(string))
        only_critical_addons_enabled  = optional(bool)
        orchestrator_version          = optional(string)
        os_disk_size_gb               = optional(number)
        os_disk_type                  = optional(string)
        os_sku                        = optional(string)
        pod_subnet_id                 = optional(string)
        proximity_placement_group_id  = optional(string)
        scale_down_mode               = optional(string)
        snapshot_id                   = optional(string)
        temporary_name_for_rotation   = optional(string)
        type                          = optional(string)
        tags                          = optional(map(string))
        ultra_ssd_enabled             = optional(bool)
        vnet_subnet_id                = optional(string)
        workload_runtime              = optional(string)
        zones                         = optional(list(string))
      })
      # TO-BE-FINISHED
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      service_principal = optional(object({
        client_id     = string
        client_secret = string
      }))
    })))
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

  azure_kubernetes_cluster_node_pool = flatten([
    for pool_id, pool in coalesce(try(local.aks.node_pool, null), {}) : merge(
      pool,
      {
        kubernetes_cluster_id = lookup(local.azurerm_kubernetes_cluster, pool.kubernetes_cluster_id, null) == null ? pool.kubernetes_cluster_id : azurerm_kubernetes_cluster.lz[pool.kubernetes_cluster_id].id
        resource_index        = join("_", [pool.kubernetes_cluster_id, pool_id])
      }
    )
  ])
}
