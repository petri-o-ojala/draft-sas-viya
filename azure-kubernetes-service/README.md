<!-- BEGIN_TF_DOCS -->

Azure Kubernetes Service

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_kubernetes_cluster.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aks"></a> [aks](#input\_aks) | Azure Kubernetes Service | <pre>object({<br>    cluster = optional(map(object({<br>      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster<br>      name                                = string<br>      resource_group_name                 = string<br>      location                            = string<br>      tags                                = optional(map(string))<br>      dns_prefix                          = optional(string)<br>      dns_prefix_private_cluster          = optional(string)<br>      automatic_channel_upgrade           = optional(string)<br>      azure_policy_enabled                = optional(bool)<br>      cost_analysis_enabled               = optional(bool)<br>      custom_ca_trust_certificates_base64 = optional(string)<br>      disk_encryption_set_id              = optional(string)<br>      http_application_routing_enabled    = optional(bool)<br>      image_cleaner_enabled               = optional(bool)<br>      image_cleaner_interval_hours        = optional(number)<br>      kubernetes_version                  = optional(string)<br>      local_account_disabled              = optional(bool)<br>      node_os_channel_upgrade             = optional(string)<br>      node_resource_group                 = optional(string)<br>      oidc_issuer_enabled                 = optional(bool)<br>      open_service_mesh_enabled           = optional(bool)<br>      private_cluster_enabled             = optional(bool)<br>      private_dns_zone_id                 = optional(string)<br>      private_cluster_public_fqdn_enabled = optional(bool)<br>      workload_identity_enabled           = optional(bool)<br>      public_network_access_enabled       = optional(bool)<br>      role_based_access_control_enabled   = optional(bool)<br>      run_command_enabled                 = optional(bool)<br>      sku_tier                            = optional(string)<br>      support_plan                        = optional(string)<br>      default_node_pool = object({<br>        name                          = string<br>        vm_size                       = string<br>        capacity_reservation_group_id = optional(string)<br>        custom_ca_trust_enabled       = optional(bool)<br>        enable_auto_scaling           = optional(bool)<br>        enable_host_encryption        = optional(bool)<br>        enable_node_public_ip         = optional(bool)<br>        gpu_instance                  = optional(string)<br>        host_group_id                 = optional(string)<br>        fips_enabled                  = optional(bool)<br>        kubelet_disk_type             = optional(string)<br>        max_pods                      = optional(number)<br>        message_of_the_day            = optional(string)<br>        node_public_ip_prefix_id      = optional(string)<br>        node_labels                   = optional(map(string))<br>        only_critical_addons_enabled  = optional(bool)<br>        orchestrator_version          = optional(string)<br>        os_disk_size_gb               = optional(number)<br>        os_disk_type                  = optional(string)<br>        os_sku                        = optional(string)<br>        pod_subnet_id                 = optional(string)<br>        proximity_placement_group_id  = optional(string)<br>        scale_down_mode               = optional(string)<br>        snapshot_id                   = optional(string)<br>        temporary_name_for_rotation   = optional(string)<br>        type                          = optional(string)<br>        tags                          = optional(map(string))<br>        ultra_ssd_enabled             = optional(bool)<br>        vnet_subnet_id                = optional(string)<br>        workload_runtime              = optional(string)<br>        zones                         = optional(list(string))<br>      })<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_entra_id"></a> [entra\_id](#input\_entra\_id) | Entra ID configuration | <pre>object({<br>    alias = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "alias": {}<br>}</pre> | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_subnet                  = optional(map(any))<br>    azure_log_analytics_workspace = optional(map(any))<br>    azure_storage_account         = optional(map(any))<br>    azure_private_dns_zone        = optional(map(any))<br>    azure_resource_group          = optional(map(any))<br>    azure_role_definition         = optional(map(any))<br>    azure_resource_principal_id   = optional(map(any))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_kubernetes_cluster"></a> [azure\_kubernetes\_cluster](#output\_azure\_kubernetes\_cluster) | Azure AKS Clusters |
<!-- END_TF_DOCS -->