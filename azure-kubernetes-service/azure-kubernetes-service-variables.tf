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
      mode                          = optional(string)
      capacity_reservation_group_id = optional(string)
      custom_ca_trust_enabled       = optional(bool)
      enable_auto_scaling           = optional(bool)
      max_count                     = optional(number)
      min_count                     = optional(number)
      node_count                    = optional(number)
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
      kubelet_config = optional(object({
        allowed_unsafe_sysctls    = optional(list(string))
        container_log_max_line    = optional(number)
        container_log_max_size_mb = optional(number)
        cpu_cfs_quota_enabled     = optional(bool)
        cpu_cfs_quota_period      = optional(number)
        cpu_manager_policy        = optional(string)
        image_gc_high_threshold   = optional(number)
        image_gc_low_threshold    = optional(number)
        pod_max_pid               = optional(number)
        topology_manager_policy   = optional(string)
      }))
      linux_os_config = optional(object({
        swap_file_size_mb             = optional(number)
        transparent_huge_page_defrag  = optional(string)
        transparent_huge_page_enabled = optional(bool)
        sysctl_config = optional(object({
          fs_aio_max_nr                      = optional(number)
          fs_file_max                        = optional(number)
          fs_inotify_max_user_watches        = optional(number)
          fs_nr_open                         = optional(number)
          kernel_threads_max                 = optional(number)
          net_core_netdev_max_backlog        = optional(number)
          net_core_optmem_max                = optional(number)
          net_core_rmem_default              = optional(number)
          net_core_rmem_max                  = optional(number)
          net_core_somaxconn                 = optional(number)
          net_core_wmem_default              = optional(number)
          net_core_wmem_max                  = optional(number)
          net_ipv4_ip_local_port_range_max   = optional(number)
          net_ipv4_ip_local_port_range_min   = optional(number)
          net_ipv4_neigh_default_gc_thresh1  = optional(number)
          net_ipv4_neigh_default_gc_thresh2  = optional(number)
          net_ipv4_neigh_default_gc_thresh3  = optional(number)
          net_ipv4_tcp_fin_timeout           = optional(number)
          net_ipv4_tcp_keepalive_intvl       = optional(number)
          net_ipv4_tcp_keepalive_probes      = optional(number)
          net_ipv4_tcp_keepalive_time        = optional(number)
          net_ipv4_tcp_max_syn_backlog       = optional(number)
          net_ipv4_tcp_max_tw_buckets        = optional(number)
          net_ipv4_tcp_tw_reuse              = optional(number)
          net_netfilter_nf_conntrack_buckets = optional(number)
          net_netfilter_nf_conntrack_max     = optional(number)
          vm_max_map_count                   = optional(number)
          vm_swappiness                      = optional(number)
          vm_vfs_cache_pressure              = optional(number)
        }))
      }))
      node_network_profile = optional(object({
        application_security_group_ids = optional(list(string))
        node_public_ip_tags            = optional(map(string))
        allowed_host_ports = optional(list(object({
          port_start = optional(number)
          port_end   = optional(number)
          protocol   = optional(string)
        })))
      }))
      upgrade_settings = optional(object({
        drain_timeout_in_minutes      = optional(number)
        node_soak_duration_in_minutes = optional(number)
        max_surge                     = optional(string)
      }))
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
        max_count                     = optional(number)
        min_count                     = optional(number)
        node_count                    = optional(number)
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
        kubelet_config = optional(object({
          allowed_unsafe_sysctls    = optional(list(string))
          container_log_max_line    = optional(number)
          container_log_max_size_mb = optional(number)
          cpu_cfs_quota_enabled     = optional(bool)
          cpu_cfs_quota_period      = optional(number)
          cpu_manager_policy        = optional(string)
          image_gc_high_threshold   = optional(number)
          image_gc_low_threshold    = optional(number)
          pod_max_pid               = optional(number)
          topology_manager_policy   = optional(string)
        }))
        linux_os_config = optional(object({
          swap_file_size_mb             = optional(number)
          transparent_huge_page_defrag  = optional(string)
          transparent_huge_page_enabled = optional(bool)
          sysctl_config = optional(object({
            fs_aio_max_nr                      = optional(number)
            fs_file_max                        = optional(number)
            fs_inotify_max_user_watches        = optional(number)
            fs_nr_open                         = optional(number)
            kernel_threads_max                 = optional(number)
            net_core_netdev_max_backlog        = optional(number)
            net_core_optmem_max                = optional(number)
            net_core_rmem_default              = optional(number)
            net_core_rmem_max                  = optional(number)
            net_core_somaxconn                 = optional(number)
            net_core_wmem_default              = optional(number)
            net_core_wmem_max                  = optional(number)
            net_ipv4_ip_local_port_range_max   = optional(number)
            net_ipv4_ip_local_port_range_min   = optional(number)
            net_ipv4_neigh_default_gc_thresh1  = optional(number)
            net_ipv4_neigh_default_gc_thresh2  = optional(number)
            net_ipv4_neigh_default_gc_thresh3  = optional(number)
            net_ipv4_tcp_fin_timeout           = optional(number)
            net_ipv4_tcp_keepalive_intvl       = optional(number)
            net_ipv4_tcp_keepalive_probes      = optional(number)
            net_ipv4_tcp_keepalive_time        = optional(number)
            net_ipv4_tcp_max_syn_backlog       = optional(number)
            net_ipv4_tcp_max_tw_buckets        = optional(number)
            net_ipv4_tcp_tw_reuse              = optional(number)
            net_netfilter_nf_conntrack_buckets = optional(number)
            net_netfilter_nf_conntrack_max     = optional(number)
            vm_max_map_count                   = optional(number)
            vm_swappiness                      = optional(number)
            vm_vfs_cache_pressure              = optional(number)
          }))
        }))
        node_network_profile = optional(object({
          application_security_group_ids = optional(list(string))
          node_public_ip_tags            = optional(map(string))
          allowed_host_ports = optional(list(object({
            port_start = optional(number)
            port_end   = optional(number)
            protocol   = optional(string)
          })))
        }))
        upgrade_settings = optional(object({
          drain_timeout_in_minutes      = optional(number)
          node_soak_duration_in_minutes = optional(number)
          max_surge                     = optional(string)
        }))
      })
      aci_connector_linux = optional(object({
        subnet_name = optional(string)
      }))
      api_server_access_profile = optional(object({
        authorized_ip_ranges     = optional(list(string))
        subnet_id                = optional(string)
        vnet_integration_enabled = optional(bool)
      }))
      auto_scaler_profile = optional(object({
        balance_similar_node_groups      = optional(bool)
        expander                         = optional(string)
        max_graceful_termination_sec     = optional(number)
        max_node_provisioning_time       = optional(number)
        max_unready_nodes                = optional(number)
        max_unready_percentage           = optional(number)
        new_pod_scale_up_delay           = optional(number)
        scale_down_delay_after_add       = optional(string)
        scale_down_delay_after_delete    = optional(string)
        scale_down_delay_after_failure   = optional(string)
        scan_interval                    = optional(string)
        scale_down_unneeded              = optional(string)
        scale_down_unready               = optional(string)
        scale_down_utilization_threshold = optional(number)
        empty_bulk_delete_max            = optional(number)
        skip_nodes_with_local_storage    = optional(bool)
        skip_nodes_with_system_pods      = optional(bool)
      }))
      azure_active_directory_role_based_access_control = optional(object({
        tenant_id              = optional(string)
        admin_group_object_ids = optional(list(string))
        azure_rbac_enabled     = optional(string)
      }))
      confidential_computing = optional(object({
        sgx_quote_helper_enabled = optional(bool)
      }))
      http_proxy_config = optional(object({
        http_proxy  = optional(string)
        https_proxy = optional(string)
        no_proxy    = optional(string)
        trusted_ca  = optional(string)
      }))
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      ingress_application_gateway = optional(object({
        gateway_id   = optional(string)
        gateway_name = optional(string)
        subnet_cidr  = optional(string)
        subnet_id    = optional(string)
      }))
      key_management_service = optional(object({
        key_vault_key_id         = optional(string)
        key_vault_network_access = optional(string)
      }))
      key_vault_secrets_provider = optional(object({
        secret_rotation_enabled  = optional(string)
        secret_rotation_interval = optional(string)
      }))
      kubelet_identity = optional(object({
        client_id                 = optional(string)
        object_id                 = optional(string)
        user_assigned_identity_id = optional(string)
      }))
      linux_profile = optional(object({
        admin_username = optional(string)
        ssh_key = optional(list(object({
          key_data = optional(string)
        })))
      }))
      maintenance_window = optional(object({
        allowed = optional(object({
          day   = string
          hours = list(number)
        }))
        not_allowed = optional(object({
          start = string
          end   = string
        }))
      }))
      maintenance_window_auto_upgrade = optional(object({
        frequency    = string
        interval     = number
        duration     = number
        day_of_week  = optional(string)
        day_of_month = optional(number)
        week_index   = optional(string)
        start_time   = optional(string)
        utc_offset   = optional(string)
        start_date   = optional(string)
        not_allowed = optional(object({
          start = string
          end   = string
        }))
      }))
      maintenance_window_node_os = optional(object({
        frequency    = string
        interval     = number
        duration     = number
        day_of_week  = optional(string)
        day_of_month = optional(number)
        week_index   = optional(string)
        start_time   = optional(string)
        utc_offset   = optional(string)
        start_date   = optional(string)
        not_allowed = optional(object({
          start = string
          end   = string
        }))
      }))
      microsoft_defender = optional(object({
        log_analytics_workspace_id = string
      }))
      monitor_metrics = optional(object({
        annotations_allowed = optional(list(string))
        labels_allowed      = optional(list(string))
      }))
      network_profile = optional(object({
        network_plugin      = string
        network_mode        = optional(string)
        network_policy      = optional(string)
        dns_service_ip      = optional(string)
        network_data_plane  = optional(string)
        network_plugin_mode = optional(string)
        outbound_type       = optional(string)
        pod_cidr            = optional(string)
        pod_cidrs           = optional(list(string))
        service_cidr        = optional(string)
        service_cidrs       = optional(list(string))
        ip_versions         = optional(list(string))
        load_balancer_sku   = optional(string)
        load_balancer_profile = optional(object({
          idle_timeout_in_minutes     = optional(number)
          managed_outbound_ip_count   = optional(number)
          managed_outbound_ipv6_count = optional(number)
          outbound_ip_address_ids     = optional(list(string))
          outbound_ip_prefix_ids      = optional(list(string))
          outbound_ports_allocated    = optional(number)
        }))
        nat_gateway_profile = optional(object({
          idle_timeout_in_minutes   = optional(number)
          managed_outbound_ip_count = optional(number)
        }))
      }))
      oms_agent = optional(object({
        log_analytics_workspace_id      = string
        msi_auth_for_monitoring_enabled = optional(bool)
      }))
      service_mesh_profile = optional(object({
        mode                             = string
        internal_ingress_gateway_enabled = optional(bool)
        external_ingress_gateway_enabled = optional(bool)
      }))
      workload_autoscaler_profile = optional(object({
        keda_enabled                    = optional(bool)
        vertical_pod_autoscaler_enabled = optional(bool)
      }))
      service_principal = optional(object({
        client_id     = string
        client_secret = string
      }))
      storage_profile = optional(object({
        blob_driver_enabled         = optional(bool)
        disk_driver_enabled         = optional(bool)
        disk_driver_version         = optional(string)
        file_driver_enabled         = optional(bool)
        snapshot_controller_enabled = optional(bool)
      }))
      web_app_routing = optional(object({
        dns_zone_ids = list(string)
      }))
      windows_profile = optional(object({
        admin_username = string
        admin_password = optional(string)
        license        = optional(string)
        gmsa = optional(object({
          dns_server  = string
          root_domain = string
        }))
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
