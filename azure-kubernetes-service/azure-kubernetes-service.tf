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

      dynamic "kubelet_config" {
        for_each = try(each.value.default_node_pool.kubelet_config, null) == null ? [] : [1]

        content {
          allowed_unsafe_sysctls    = each.value.default_node_pool.kubelet_config.allowed_unsafe_sysctls
          container_log_max_line    = each.value.default_node_pool.kubelet_config.container_log_max_line
          container_log_max_size_mb = each.value.default_node_pool.kubelet_config.container_log_max_size_mb
          cpu_cfs_quota_enabled     = each.value.default_node_pool.kubelet_config.cpu_cfs_quota_enabled
          cpu_cfs_quota_period      = each.value.default_node_pool.kubelet_config.cpu_cfs_quota_period
          cpu_manager_policy        = each.value.default_node_pool.kubelet_config.cpu_manager_policy
          image_gc_high_threshold   = each.value.default_node_pool.kubelet_config.image_gc_high_threshold
          image_gc_low_threshold    = each.value.default_node_pool.kubelet_config.image_gc_low_threshold
          pod_max_pid               = each.value.default_node_pool.kubelet_config.pod_max_pid
          topology_manager_policy   = each.value.default_node_pool.kubelet_config.topology_manager_policy
        }
      }

      dynamic "linux_os_config" {
        for_each = try(each.value.default_node_pool.linux_os_config, null) == null ? [] : [1]

        content {
          swap_file_size_mb             = each.value.default_node_pool.linux_os_config.swap_file_size_mb
          transparent_huge_page_defrag  = each.value.default_node_pool.linux_os_config.transparent_huge_page_defrag
          transparent_huge_page_enabled = each.value.default_node_pool.linux_os_config.transparent_huge_page_enabled

          dynamic "sysctl_config" {
            for_each = try(each.value.default_node_pool.linux_os_config.sysctl_config, null) == null ? [] : [1]

            content {
              fs_aio_max_nr                      = each.value.default_node_pool.linux_os_config.sysctl_config.fs_aio_max_nr
              fs_file_max                        = each.value.default_node_pool.linux_os_config.sysctl_config.fs_file_max
              fs_inotify_max_user_watches        = each.value.default_node_pool.linux_os_config.sysctl_config.fs_inotify_max_user_watches
              fs_nr_open                         = each.value.default_node_pool.linux_os_config.sysctl_config.fs_nr_open
              kernel_threads_max                 = each.value.default_node_pool.linux_os_config.sysctl_config.kernel_threads_max
              net_core_netdev_max_backlog        = each.value.default_node_pool.linux_os_config.sysctl_config.net_core_netdev_max_backlog
              net_core_optmem_max                = each.value.default_node_pool.linux_os_config.sysctl_config.net_core_optmem_max
              net_core_rmem_default              = each.value.default_node_pool.linux_os_config.sysctl_config.net_core_rmem_default
              net_core_rmem_max                  = each.value.default_node_pool.linux_os_config.sysctl_config.net_core_rmem_max
              net_core_somaxconn                 = each.value.default_node_pool.linux_os_config.sysctl_config.net_core_somaxconn
              net_core_wmem_default              = each.value.default_node_pool.linux_os_config.sysctl_config.net_core_wmem_default
              net_core_wmem_max                  = each.value.default_node_pool.linux_os_config.sysctl_config.net_core_wmem_max
              net_ipv4_ip_local_port_range_max   = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_ip_local_port_range_max
              net_ipv4_ip_local_port_range_min   = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_ip_local_port_range_min
              net_ipv4_neigh_default_gc_thresh1  = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_neigh_default_gc_thresh1
              net_ipv4_neigh_default_gc_thresh2  = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_neigh_default_gc_thresh2
              net_ipv4_neigh_default_gc_thresh3  = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_neigh_default_gc_thresh3
              net_ipv4_tcp_fin_timeout           = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_fin_timeout
              net_ipv4_tcp_keepalive_intvl       = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_keepalive_intvl
              net_ipv4_tcp_keepalive_probes      = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_keepalive_probes
              net_ipv4_tcp_keepalive_time        = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_keepalive_time
              net_ipv4_tcp_max_syn_backlog       = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_max_syn_backlog
              net_ipv4_tcp_max_tw_buckets        = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_max_tw_buckets
              net_ipv4_tcp_tw_reuse              = each.value.default_node_pool.linux_os_config.sysctl_config.net_ipv4_tcp_tw_reuse
              net_netfilter_nf_conntrack_buckets = each.value.default_node_pool.linux_os_config.sysctl_config.net_netfilter_nf_conntrack_buckets
              net_netfilter_nf_conntrack_max     = each.value.default_node_pool.linux_os_config.sysctl_config.net_netfilter_nf_conntrack_max
              vm_max_map_count                   = each.value.default_node_pool.linux_os_config.sysctl_config.vm_max_map_count
              vm_swappiness                      = each.value.default_node_pool.linux_os_config.sysctl_config.vm_swappiness
              vm_vfs_cache_pressure              = each.value.default_node_pool.linux_os_config.sysctl_config.vm_vfs_cache_pressure
            }
          }
        }
      }

      dynamic "node_network_profile" {
        for_each = try(each.value.default_node_pool.node_network_profile, null) == null ? [] : [1]

        content {
          application_security_group_ids = each.value.default_node_pool.node_network_profile.application_security_group_ids
          node_public_ip_tags            = each.value.default_node_pool.node_network_profile.node_public_ip_tags

          dynamic "allowed_host_ports" {
            for_each = coalesce(each.value.default_node_pool.node_network_profile.allowed_host_ports, [])

            content {
              port_start = allowed_host_ports.value.port_start
              port_end   = allowed_host_ports.value.port_end
              protocol   = allowed_host_ports.value.protocol
            }
          }
        }
      }

      dynamic "upgrade_settings" {
        for_each = try(each.value.default_node_pool.upgrade_settings, null) == null ? [] : [1]

        content {
          drain_timeout_in_minutes      = each.value.default_node_pool.upgrade_settings.drain_timeout_in_minutes
          node_soak_duration_in_minutes = each.value.default_node_pool.upgrade_settings.node_soak_duration_in_minutes
          max_surge                     = each.value.default_node_pool.upgrade_settings.max_surge
        }
      }
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

  dynamic "confidential_computing" {
    for_each = try(each.value.confidential_computing, null) == null ? [] : [1]

    content {
      sgx_quote_helper_enabled = each.value.confidential_computing.sgx_quote_helper_enabled
    }
  }

  dynamic "http_proxy_config" {
    for_each = try(each.value.http_proxy_config, null) == null ? [] : [1]

    content {
      http_proxy  = each.value.http_proxy_config.http_proxy
      https_proxy = each.value.http_proxy_config.https_proxy
      no_proxy    = each.value.http_proxy_config.no_proxy
      trusted_ca  = each.value.http_proxy_config.trusted_ca
    }
  }

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "ingress_application_gateway" {
    for_each = try(each.value.ingress_application_gateway, null) == null ? [] : [1]

    content {
      gateway_id   = each.value.ingress_application_gateway.gateway_id
      gateway_name = each.value.ingress_application_gateway.gateway_name
      subnet_cidr  = each.value.ingress_application_gateway.subnet_cidr
      subnet_id    = each.value.ingress_application_gateway.subnet_id
    }
  }

  dynamic "key_management_service" {
    for_each = try(each.value.key_management_service, null) == null ? [] : [1]

    content {
      key_vault_key_id         = each.value.key_management_service.key_vault_key_id
      key_vault_network_access = each.value.key_management_service.key_vault_network_access
    }
  }
  dynamic "key_vault_secrets_provider" {
    for_each = try(each.value.key_vault_secrets_provider, null) == null ? [] : [1]

    content {
      secret_rotation_enabled  = each.value.key_vault_secrets_provider.secret_rotation_enabled
      secret_rotation_interval = each.value.key_vault_secrets_provider.secret_rotation_interval
    }
  }

  dynamic "kubelet_identity" {
    for_each = try(each.value.kubelet_identity, null) == null ? [] : [1]

    content {
      client_id                 = each.value.kubelet_identity.client_id
      object_id                 = each.value.kubelet_identity.object_id
      user_assigned_identity_id = each.value.kubelet_identity.user_assigned_identity_id
    }
  }

  dynamic "linux_profile" {
    for_each = try(each.value.linux_profile, null) == null ? [] : [1]

    content {
      admin_username = each.value.linux_profile.admin_username

      dynamic "ssh_key" {
        for_each = coalesce(each.value.linux_profile.ssh_key, [])

        content {
          key_data = ssh_key.value.key_data
        }
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = try(each.value.maintenance_window, null) == null ? [] : [1]

    content {
      dynamic "allowed" {
        for_each = coalesce(each.value.maintenance_window.allowed, [])

        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }

      dynamic "not_allowed" {
        for_each = coalesce(each.value.maintenance_window.not_allowed, [])

        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "maintenance_window_auto_upgrade" {
    for_each = try(each.value.maintenance_window_auto_upgrade, null) == null ? [] : [1]

    content {
      frequency    = each.value.maintenance_window_auto_upgrade.frequency
      interval     = each.value.maintenance_window_auto_upgrade.interval
      duration     = each.value.maintenance_window_auto_upgrade.duration
      day_of_week  = each.value.maintenance_window_auto_upgrade.day_of_week
      day_of_month = each.value.maintenance_window_auto_upgrade.day_of_month
      week_index   = each.value.maintenance_window_auto_upgrade.week_index
      start_time   = each.value.maintenance_window_auto_upgrade.start_time
      utc_offset   = each.value.maintenance_window_auto_upgrade.utc_offset
      start_date   = each.value.maintenance_window_auto_upgrade.start_date

      dynamic "not_allowed" {
        for_each = coalesce(each.value.maintenance_window_auto_upgrade.not_allowed, [])

        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "maintenance_window_node_os" {
    for_each = try(each.value.maintenance_window_node_os, null) == null ? [] : [1]

    content {
      frequency    = each.value.maintenance_window_node_os.frequency
      interval     = each.value.maintenance_window_node_os.interval
      duration     = each.value.maintenance_window_node_os.duration
      day_of_week  = each.value.maintenance_window_node_os.day_of_week
      day_of_month = each.value.maintenance_window_node_os.day_of_month
      week_index   = each.value.maintenance_window_node_os.week_index
      start_time   = each.value.maintenance_window_node_os.start_time
      utc_offset   = each.value.maintenance_window_node_os.utc_offset
      start_date   = each.value.maintenance_window_node_os.start_date

      dynamic "not_allowed" {
        for_each = coalesce(each.value.maintenance_window_node_os.not_allowed, [])

        content {
          start = not_allowed.value.start
          end   = not_allowed.value.end
        }
      }
    }
  }

  dynamic "microsoft_defender" {
    for_each = try(each.value.microsoft_defender, null) == null ? [] : [1]

    content {
      log_analytics_workspace_id = each.value.microsoft_defender.log_analytics_workspace_id
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
      network_plugin      = each.value.network_profile.network_plugin
      network_mode        = each.value.network_profile.network_mode
      network_policy      = each.value.network_profile.network_policy
      dns_service_ip      = each.value.network_profile.dns_service_ip
      network_data_plane  = each.value.network_profile.network_data_plane
      network_plugin_mode = each.value.network_profile.network_plugin_mode
      outbound_type       = each.value.network_profile.outbound_type
      pod_cidr            = each.value.network_profile.pod_cidr
      pod_cidrs           = each.value.network_profile.pod_cidrs
      service_cidr        = each.value.network_profile.service_cidr
      service_cidrs       = each.value.network_profile.service_cidrs
      ip_versions         = each.value.network_profile.ip_versions
      load_balancer_sku   = each.value.network_profile.load_balancer_sku

      dynamic "load_balancer_profile" {
        for_each = try(each.value.network_profile.load_balancer_profile, null) == null ? [] : [1]

        content {
          idle_timeout_in_minutes     = each.value.network_profile.load_balancer_profile.idle_timeout_in_minutes
          managed_outbound_ip_count   = each.value.network_profile.load_balancer_profile.managed_outbound_ip_count
          managed_outbound_ipv6_count = each.value.network_profile.load_balancer_profile.managed_outbound_ipv6_count
          outbound_ip_address_ids     = each.value.network_profile.load_balancer_profile.outbound_ip_address_ids
          outbound_ip_prefix_ids      = each.value.network_profile.load_balancer_profile.outbound_ip_prefix_ids
          outbound_ports_allocated    = each.value.network_profile.load_balancer_profile.outbound_ports_allocated
        }
      }

      dynamic "nat_gateway_profile" {
        for_each = try(each.value.network_profile.nat_gateway_profile, null) == null ? [] : [1]

        content {
          idle_timeout_in_minutes   = each.value.network_profile.nat_gateway_profile.idle_timeout_in_minutes
          managed_outbound_ip_count = each.value.network_profile.nat_gateway_profile.managed_outbound_ip_count
        }
      }
    }
  }

  dynamic "oms_agent" {
    for_each = try(each.value.oms_agent, null) == null ? [] : [1]

    content {
      log_analytics_workspace_id      = each.value.oms_agent.log_analytics_workspace_id
      msi_auth_for_monitoring_enabled = each.value.oms_agent.msi_auth_for_monitoring_enabled
    }
  }

  dynamic "service_mesh_profile" {
    for_each = try(each.value.service_mesh_profile, null) == null ? [] : [1]

    content {
      mode                             = each.value.service_mesh_profile.mode
      internal_ingress_gateway_enabled = each.value.service_mesh_profile.internal_ingress_gateway_enabled
      external_ingress_gateway_enabled = each.value.service_mesh_profile.external_ingress_gateway_enabled
    }
  }

  dynamic "workload_autoscaler_profile" {
    for_each = try(each.value.workload_autoscaler_profile, null) == null ? [] : [1]

    content {
      keda_enabled                    = each.value.workload_autoscaler_profile.keda_enabled
      vertical_pod_autoscaler_enabled = each.value.workload_autoscaler_profile.vertical_pod_autoscaler_enabled

    }
  }

  dynamic "service_principal" {
    for_each = try(each.value.service_principal, null) == null ? [] : [1]

    content {
      client_id     = each.value.service_principal.client_id
      client_secret = each.value.service_principal.client_secret
    }
  }

  dynamic "storage_profile" {
    for_each = try(each.value.storage_profile, null) == null ? [] : [1]

    content {
      blob_driver_enabled         = each.value.storage_profile.blob_driver_enabled
      disk_driver_enabled         = each.value.storage_profile.disk_driver_enabled
      disk_driver_version         = each.value.storage_profile.disk_driver_version
      file_driver_enabled         = each.value.storage_profile.file_driver_enabled
      snapshot_controller_enabled = each.value.storage_profile.snapshot_controller_enabled
    }
  }

  dynamic "web_app_routing" {
    for_each = try(each.value.web_app_routing, null) == null ? [] : [1]

    content {
      dns_zone_ids = each.value.web_app_routing.dns_zone_ids
    }
  }

  dynamic "windows_profile" {
    for_each = try(each.value.windows_profile, null) == null ? [] : [1]

    content {
      admin_username = each.value.windows_profile.admin_username
      admin_password = each.value.windows_profile.admin_password
      license        = each.value.windows_profile.license

      dynamic "gmsa" {
        for_each = try(each.value.windows_profile.gmsa, null) == null ? [] : [1]

        content {
          dns_server  = each.value.windows_profile.gmsa.dns_server
          root_domain = each.value.windows_profile.gmsa.root_domain
        }
      }
    }
  }
}
