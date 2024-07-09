<!-- BEGIN_TF_DOCS -->

Azure Storage Accounts

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
| [azurerm_management_lock.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_monitor_diagnostic_setting.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_storage_account.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_log_analytics_workspace = optional(map(any))<br>    azure_private_dns_zone        = optional(map(any))<br>    azure_subnet                  = optional(map(any))<br>  })</pre> | `{}` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | Azure Storage Accounts | <pre>object({<br>    account = optional(map(object({<br>      name                              = string<br>      resource_group_name               = string<br>      location                          = string<br>      account_kind                      = optional(string)<br>      account_tier                      = string<br>      account_replication_type          = string<br>      cross_tenant_replication_enabled  = optional(bool)<br>      access_tier                       = optional(string)<br>      enable_https_traffic_only         = optional(bool)<br>      min_tls_version                   = optional(string)<br>      shared_access_key_enabled         = optional(bool)<br>      public_network_access_enabled     = optional(bool)<br>      default_to_oauth_authentication   = optional(bool)<br>      is_hns_enabled                    = optional(bool)<br>      nfsv3_enabled                     = optional(bool)<br>      large_file_share_enabled          = optional(bool)<br>      local_user_enabled                = optional(bool)<br>      queue_encryption_key_type         = optional(string)<br>      table_encryption_key_type         = optional(string)<br>      infrastructure_encryption_enabled = optional(bool)<br>      allowed_copy_scope                = optional(string)<br>      sftp_enabled                      = optional(bool)<br>      tags                              = optional(map(string))<br>      management_lock = optional(object({<br>        name       = optional(string)<br>        lock_level = optional(string, "CanNotDelete")<br>        notes      = optional(string)<br>      }))<br>      diagnostic_setting = optional(list(object({<br>        name                           = optional(string)<br>        service                        = optional(string)<br>        eventhub_name                  = optional(string)<br>        eventhub_authorization_rule_id = optional(string)<br>        log_analytics_workspace_id     = optional(string)<br>        storage_account_id             = optional(string)<br>        log_analytics_destination_type = optional(string)<br>        partner_solution_id            = optional(string)<br>        enabled_log = optional(list(object({<br>          category       = optional(string)<br>          category_group = optional(string)<br>          retention_policy = optional(object({<br>            days    = optional(number)<br>            enabled = optional(bool)<br>          }))<br>        })))<br>        metric = optional(list(object({<br>          category = string<br>          enabled  = optional(bool)<br>          retention_policy = optional(object({<br>            days    = optional(number)<br>            enabled = optional(bool)<br>          }))<br>        })))<br>      })))<br>      private_endpoint = optional(list(object({<br>        name                          = string<br>        resource_group_name           = optional(string)<br>        location                      = optional(string)<br>        subnet_id                     = optional(string)<br>        custom_network_interface_name = optional(string)<br>        tags                          = optional(map(string))<br>        private_dns_zone_group = optional(object({<br>          name                 = string<br>          private_dns_zone_ids = list(string)<br>        }))<br>        private_service_connection = optional(object({<br>          name                              = string<br>          is_manual_connection              = bool<br>          private_connection_resource_id    = optional(string)<br>          private_connection_resource_alias = optional(string)<br>          subresource_names                 = optional(list(string))<br>          request_message                   = optional(string)<br>        }))<br>        ip_configuration = optional(list(object({<br>          name               = string<br>          private_ip_address = string<br>          subresource_name   = optional(string)<br>          member_name        = optional(string)<br>        })))<br>      })))<br>      custom_domain = optional(object({<br>        name          = string<br>        use_subdomain = optional(bool)<br><br>      }))<br>      customer_managed_key = optional(object({<br>        key_vault_key_id          = string<br>        user_assigned_identity_id = string<br>      }))<br>      blob_properties = optional(object({<br>        versioning_enabled            = optional(bool)<br>        change_feed_enabled           = optional(bool)<br>        change_feed_retention_in_days = optional(number)<br>        default_service_version       = optional(string)<br>        last_access_time_enabled      = optional(bool)<br>        cors_rule = optional(object({<br>          allowed_headers    = list(string)<br>          allowed_methods    = list(string)<br>          allowed_origins    = list(string)<br>          exposed_headers    = list(string)<br>          max_age_in_seconds = number<br>        }))<br>        delete_retention_policy = optional(object({<br>          days = number<br>        }))<br>        restore_policy = optional(object({<br>          days = number<br>        }))<br>        container_delete_retention_policy = optional(object({<br>          days = number<br>        }))<br>      }))<br>      network_rules = optional(object({<br>        default_action             = string<br>        bypass                     = optional(string)<br>        ip_rules                   = optional(list(string))<br>        virtual_network_subnet_ids = optional(list(string))<br>        private_link_access = optional(object({<br>          endpoint_resource_id = string<br>          endpoint_tenant_id   = optional(string)<br>        }))<br>      }))<br>      container = optional(list(object({<br>        name                              = string<br>        storage_account_name              = optional(string)<br>        container_access_type             = optional(string)<br>        default_encryption_scope          = optional(string)<br>        encryption_scope_override_enabled = optional(bool)<br>        metadata                          = optional(map(string))<br>      })))<br>    })))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_storage_account"></a> [azure\_storage\_account](#output\_azure\_storage\_account) | Azure Storage Accounts |
| <a name="output_azure_storage_container"></a> [azure\_storage\_container](#output\_azure\_storage\_container) | Azure Storage Account Containers |
<!-- END_TF_DOCS -->