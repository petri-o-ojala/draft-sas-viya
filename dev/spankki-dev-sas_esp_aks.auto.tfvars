#
# SAS ESP Azure Kubernetes Service
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_aks_identity = {
  user_assigned = {
    "sas-esp" = {
      name                = "identity-spankki-afc-esp-we-aks-dev"
      location            = "westeurope"
      resource_group_name = "rg-spankki-afc-esp-we-identity-dev"
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
      #
      # Permissions for AKS
      iam = [
        {
          scope                = "/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/virtualNetworks/spankki-vnet-afc-dev-we-internal-01"
          role_definition_name = "Network Contributor"
        },
        {
          scope                = "/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.westeurope.azmk8s.io"
          role_definition_name = "Private DNS Zone Contributor"
        }
      ]
    }
  }
}

sas_esp_aks_private_endpoint = {

}

/*
sas_esp_aks = {
  cluster = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
    "sas-esp" = {
      resource_group_name       = "rg-spankki-afc-esp-we-aks-dev"
      location                  = "westeurope"
      name                      = "aks-spankki-afc-esp-we-dev"
      dns_prefix                = "spankki-esp-dev"
      availability_zones        = ["1", "2", "3"]
      enable_auto_scaling       = true
      enable_node_public_ip     = false
      kubernetes_version        = "1.28.9"
      automatic_channel_upgrade = "stable"
      sku_tier                  = "Standard"
      pod_subnet_id             = "sas-esp-dev_sas-esp-dev-aks"
      node_resource_group       = "rg-spankki-afc-esp-we-aks-nodes-dev"
      azure_policy_enabled      = true
      private_cluster_enabled   = true
      private_dns_zone_id               = "privatelink-aks"
      role_based_access_control_enabled = true
      # enable_log_analytics_workspace = true
      network_plugin               = "azure"
      network_policy               = "calico"
      only_critical_addons_enabled = true
      default_node_pool = {
        name                = "default"
        enable_auto_scaling = false
        node_count          = 1
        vm_size             = "Standard_E4s_v5"
        upgrade_settings = {
          drain_timeout_in_minutes      = 0
          max_surge                     = "10%"
          node_soak_duration_in_minutes = 0
        }
        tags = {
          "application" = "AFC"
          "contact"     = "anssi.yli-leppala@s-pankki.fi"
          "costcenter"  = "3730403"
          "department"  = "S-Pankki"
          "environment" = "dev"
          "terraform"   = "true"
          "managed_by"  = "tietoevry"
        }
      }
      identity = {
        type = "SystemAssigned"
        NOT_USED_YET_identity_ids = [
          "/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-identity-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-spankki-afc-esp-we-aks-dev"
        ]
      }
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
  }
  node_pool = {
    #
    # Managed configuration for the AKS default cluster.  To update the default cluster, chnage this configuration first to
    # update the default cluster's configuration.  After updating and applying the change, change the AKS cluster configuration
    # for default_node_pool to match the new configuration.  This should allow one to update the default node pool without
    # re-creating the complete cluster.
    #
    "default-pool" = {
      name                  = "default"
      kubernetes_cluster_id = "sas-esp"
      vm_size               = "Standard_E4s_v5"
      os_disk_size          = 200
      min_nodes             = 2
      max_nodes             = 3
      max_pods              = 110
      enable_auto_scaling   = false
      enable_node_public_ip = false
      mode                  = "System"
      upgrade_settings = {
        drain_timeout_in_minutes      = 0
        max_surge                     = "10%"
        node_soak_duration_in_minutes = 0
      }
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
    #
    # SAS ESP node pools
    #
    "sas-esp-cas" = {
      name                  = "cas"
      kubernetes_cluster_id = "sas-esp"
      vm_size               = "Standard_E4ds_v5"
      os_disk_size          = 200
      min_nodes             = 2
      max_nodes             = 3
      max_pods              = 110
      node_taints           = ["workload.sas.com/class=cas:NoSchedule"]
      node_labels = {
        "workload.sas.com/class" = "cas"
      }
      enable_auto_scaling   = true
      enable_node_public_ip = false
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
    "sas-esp-compute" = {
      name                  = "compute"
      kubernetes_cluster_id = "sas-esp"
      vm_size               = "Standard_D4ds_v5"
      os_disk_size          = 200
      min_nodes             = 2
      max_nodes             = 3
      max_pods              = 110
      node_taints           = ["workload.sas.com/class=compute:NoSchedule"]
      node_labels = {
        "workload.sas.com/class"        = "compute"
        "launcher.sas.com/prepullImage" = "sas-programming-environment"
      }
      enable_auto_scaling   = true
      enable_node_public_ip = false
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
    "sas-esp-stateless" = {
      name                  = "stateless"
      kubernetes_cluster_id = "sas-esp"
      vm_size               = "Standard_D4s_v5"
      os_disk_size          = 200
      min_nodes             = 2
      max_nodes             = 4
      max_pods              = 110
      node_taints           = ["workload.sas.com/class=stateless:NoSchedule"]
      node_labels = {
        "workload.sas.com/class" = "stateless"
      }
      enable_auto_scaling   = true
      enable_node_public_ip = false
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
    "sas-esp-stateful" = {
      name                  = "stateful"
      kubernetes_cluster_id = "sas-esp"
      vm_size               = "Standard_D4s_v5"
      os_disk_size          = 200
      min_nodes             = 2
      max_nodes             = 3
      max_pods              = 110
      node_taints           = ["workload.sas.com/class=stateful:NoSchedule"]
      node_labels = {
        "workload.sas.com/class" = "stateful"
      }
      enable_auto_scaling   = true
      enable_node_public_ip = false
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
  }
}
*/
