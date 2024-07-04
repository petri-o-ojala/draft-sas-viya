#
# Azure Kubernetes Service
#

locals {
  azurerm_kubernetes_cluster = azurerm_kubernetes_cluster.lz
}

resource "azurerm_kubernetes_cluster" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
  for_each = {
    for cluster in local.azure_kubernetes_cluster : cluster.resource_index => cluster
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  dns_prefix                          = each.value.dns_prefix
  dns_prefix_private_cluster          = each.value.dns_prefix_private_cluster
  automatic_channel_upgrade           = each.value.automatic_channel_upgrade
  azure_policy_enabled                = each.value.azure_policy_enabled
  cost_analysis_enabled               = each.value.cost_analysis_enabled
  custom_ca_trust_certificates_base64 = each.value.custom_ca_trust_certificates_base64
  disk_encryption_set_id              = each.value.disk_encryption_set_id
  http_application_routing_enabled    = each.value.http_application_routing_enabled
  image_cleaner_enabled               = each.value.image_cleaner_enabled
  image_cleaner_interval_hours        = each.value.image_cleaner_interval_hours
  kubernetes_version                  = each.value.kubernetes_version
  local_account_disabled              = each.value.local_account_disabled
  node_os_channel_upgrade             = each.value.node_os_channel_upgrade
  node_resource_group                 = each.value.node_resource_group
  oidc_issuer_enabled                 = each.value.oidc_issuer_enabled
  open_service_mesh_enabled           = each.value.open_service_mesh_enabled
  private_cluster_enabled             = each.value.private_cluster_enabled
  private_dns_zone_id                 = each.value.private_dns_zone_id
  private_cluster_public_fqdn_enabled = each.value.private_cluster_public_fqdn_enabled
  workload_identity_enabled           = each.value.workload_identity_enabled
  public_network_access_enabled       = each.value.public_network_access_enabled
  role_based_access_control_enabled   = each.value.role_based_access_control_enabled
  run_command_enabled                 = each.value.run_command_enabled
  sku_tier                            = each.value.sku_tier
  support_plan                        = each.value.support_plan

  dynamic "default_node_pool" {
    for_each = try(each.value.default_node_pool, null) == null ? [] : [1]

    content {
      name                          = each.value.default_node_pool.name
      vm_size                       = each.value.default_node_pool.vm_size
      capacity_reservation_group_id = each.value.default_node_pool.capacity_reservation_group_id
      custom_ca_trust_enabled       = each.value.default_node_pool.custom_ca_trust_enabled
      enable_auto_scaling           = each.value.default_node_pool.enable_auto_scaling
      enable_host_encryption        = each.value.default_node_pool.enable_host_encryption
      enable_node_public_ip         = each.value.default_node_pool.enable_node_public_ip
      gpu_instance                  = each.value.default_node_pool.gpu_instance
      host_group_id                 = each.value.default_node_pool.host_group_id
      fips_enabled                  = each.value.default_node_pool.fips_enabled
      kubelet_disk_type             = each.value.default_node_pool.kubelet_disk_type
      max_pods                      = each.value.default_node_pool.max_pods
      message_of_the_day            = each.value.default_node_pool.message_of_the_day
      node_public_ip_prefix_id      = each.value.default_node_pool.node_public_ip_prefix_id
      node_labels                   = each.value.default_node_pool.node_labels
      only_critical_addons_enabled  = each.value.default_node_pool.only_critical_addons_enabled
      orchestrator_version          = each.value.default_node_pool.orchestrator_version
      os_disk_size_gb               = each.value.default_node_pool.os_disk_size_gb
      os_disk_type                  = each.value.default_node_pool.os_disk_type
      os_sku                        = each.value.default_node_pool.os_sku
      pod_subnet_id                 = each.value.default_node_pool.pod_subnet_id
      proximity_placement_group_id  = each.value.default_node_pool.proximity_placement_group_id
      scale_down_mode               = each.value.default_node_pool.scale_down_mode
      snapshot_id                   = each.value.default_node_pool.snapshot_id
      temporary_name_for_rotation   = each.value.default_node_pool.temporary_name_for_rotation
      type                          = each.value.default_node_pool.type
      tags                          = each.value.default_node_pool.tags
      ultra_ssd_enabled             = each.value.default_node_pool.ultra_ssd_enabled
      vnet_subnet_id                = each.value.default_node_pool.vnet_subnet_id
      workload_runtime              = each.value.default_node_pool.workload_runtime
      zones                         = each.value.default_node_pool.zones

      /*
      dynamic "kubelet_config" {}
      dynamic "linux_os_config" {}
      dynamic "node_network_profile" {}
      dynamic "upgrade_settings" {}
*/
    }
  }

  dynamic "aci_connector_linux" {
    for_each = try(each.value.aci_connector_linux, null) == null ? [] : [1]

    content {
      subnet_name = each.value.aci_connector_linux.subnet_name
    }
  }

  dynamic "api_server_access_profile" {
    for_each = try(each.value.api_server_access_profile, null) == null ? [] : [1]

    content {
      authorized_ip_ranges     = each.value.api_server_access_profile.authorized_ip_ranges
      subnet_id                = each.value.api_server_access_profile.subnet_id
      vnet_integration_enabled = each.value.api_server_access_profile.vnet_integration_enabled
    }
  }

  dynamic "auto_scaler_profile" {
    for_each = try(each.value.auto_scaler_profile, null) == null ? [] : [1]

    content {
      balance_similar_node_groups      = each.value.auto_scaler_profile.balance_similar_node_groups
      expander                         = each.value.auto_scaler_profile.expander
      max_graceful_termination_sec     = each.value.auto_scaler_profile.max_graceful_termination_sec
      max_node_provisioning_time       = each.value.auto_scaler_profile.max_node_provisioning_time
      max_unready_nodes                = each.value.auto_scaler_profile.max_unready_nodes
      max_unready_percentage           = each.value.auto_scaler_profile.max_unready_percentage
      new_pod_scale_up_delay           = each.value.auto_scaler_profile.new_pod_scale_up_delay
      scale_down_delay_after_add       = each.value.auto_scaler_profile.scale_down_delay_after_add
      scale_down_delay_after_delete    = each.value.auto_scaler_profile.scale_down_delay_after_delete
      scale_down_delay_after_failure   = each.value.auto_scaler_profile.scale_down_delay_after_failure
      scan_interval                    = each.value.auto_scaler_profile.scan_interval
      scale_down_unneeded              = each.value.auto_scaler_profile.scale_down_unneeded
      scale_down_unready               = each.value.auto_scaler_profile.scale_down_unready
      scale_down_utilization_threshold = each.value.auto_scaler_profile.scale_down_utilization_threshold
      empty_bulk_delete_max            = each.value.auto_scaler_profile.empty_bulk_delete_max
      skip_nodes_with_local_storage    = each.value.auto_scaler_profile.skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = each.value.auto_scaler_profile.skip_nodes_with_system_pods
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = try(each.value.azure_active_directory_role_based_access_control, null) == null ? [] : [1]

    content {
      managed                = each.value.azure_active_directory_role_based_access_control.managed
      tenant_id              = each.value.azure_active_directory_role_based_access_control.tenant_id
      admin_group_object_ids = each.value.azure_active_directory_role_based_access_control.admin_group_object_ids
      azure_rbac_enabled     = each.value.azure_active_directory_role_based_access_control.azure_rbac_enabled
    }
  }

  /*
  dynamic "confidential_computing" {
    for_each = try(each.value.confidential_computing, null) == null ? [] : [1]

    content {
      sgx_quote_helper_enabled = each.value.confidential_computing.sgx_quote_helper_enabled
    }
  }

  dynamic "http_proxy_config" {
    for_each = try(each.value.http_proxy_config, null) == null ? [] : [1]

    content {
    }
  }
  */

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  /*
  dynamic "ingress_application_gateway" {
    for_each = try(each.value.ingress_application_gateway, null) == null ? [] : [1]

    content {
    }
  }
  dynamic "key_management_service" {
    for_each = try(each.value.key_management_service, null) == null ? [] : [1]

    content {
    }
  }
  dynamic "key_vault_secrets_provider" {
    for_each = try(each.value.key_vault_secrets_provider, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "kubelet_identity" {
    for_each = try(each.value.kubelet_identity, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "linux_profile" {
    for_each = try(each.value.linux_profile, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "maintenance_window" {
    for_each = try(each.value.maintenance_window, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = try(each.value.maintenance_window_auto_upgrade, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "maintenance_window_node_os" {
    for_each = try(each.value.maintenance_window_node_os, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "microsoft_defender" {
    for_each = try(each.value.microsoft_defender, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "monitor_metrics" {
    for_each = try(each.value.monitor_metrics, null) == null ? [] : [1]

    content {
      annotations_allowed = each.value.monitor_metrics.annotations_allowed
      labels_allowed      = each.value.monitor_metrics.labels_allowed
    }
  }

  dynamic "network_profile" {
    for_each = try(each.value.network_profile, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "oms_agent" {
    for_each = try(each.value.oms_agent, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "service_mesh_profile" {
    for_each = try(each.value.service_mesh_profile, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = try(each.value.workload_autoscaler_profile, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "service_principal" {
    for_each = try(each.value.service_principal, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "storage_profile" {
    for_each = try(each.value.storage_profile, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "web_app_routing" {
    for_each = try(each.value.web_app_routing, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "windows_profile" {
    for_each = try(each.value.windows_profile, null) == null ? [] : [1]

    content {
    }
  }
*/
}
