<!-- BEGIN_TF_DOCS -->

Azure Keyvault

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
| [azurerm_key_vault.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_management_lock.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_monitor_diagnostic_setting.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_keyvault"></a> [keyvault](#input\_keyvault) | Azure Keyvaults | <pre>map(object({<br>    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault<br>    name                = string<br>    custom_metadata     = optional(map(string))<br>    resource_group_name = string<br>    location            = optional(string)<br>    sku_name            = string<br>    tenant_id           = string<br>    tags                = optional(map(string))<br>    management_lock = optional(object({<br>      name       = optional(string)<br>      lock_level = optional(string, "CanNotDelete")<br>      notes      = optional(string)<br>    }))<br>    diagnostic_setting = optional(object({<br>      name                           = optional(string)<br>      custom_metadata                = optional(map(string))<br>      eventhub_name                  = optional(string)<br>      eventhub_authorization_rule_id = optional(string)<br>      log_analytics_workspace_id     = optional(string)<br>      storage_account_id             = optional(string)<br>      log_analytics_destination_type = optional(string)<br>      partner_solution_id            = optional(string)<br>      enabled_log = optional(list(object({<br>        category       = optional(string)<br>        category_group = optional(string)<br>        retention_policy = optional(object({<br>          days    = optional(number)<br>          enabled = optional(bool)<br>        }))<br>      })))<br>      metric = optional(list(object({<br>        category = string<br>        enabled  = optional(bool)<br>        retention_policy = optional(object({<br>          days    = optional(number)<br>          enabled = optional(bool)<br>        }))<br>      })))<br>    }))<br>    enabled_for_deployment          = optional(bool)<br>    enabled_for_disk_encryption     = optional(bool)<br>    enabled_for_template_deployment = optional(bool)<br>    enable_rbac_authorization       = optional(bool)<br>    purge_protection_enabled        = optional(bool)<br>    public_network_access_enabled   = optional(bool)<br>    soft_delete_retention_days      = optional(number)<br>    network_acls = optional(object({<br>      bypass                     = string<br>      default_action             = string<br>      ip_rules                   = optional(list(string))<br>      virtual_network_subnet_ids = optional(list(string))<br>    }))<br>    contact = optional(object({<br>      email = string<br>      name  = optional(string)<br>      phone = optional(string)<br>    }))<br>    private_endpoint = optional(list(object({<br>      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint<br>      name                          = string<br>      custom_metadata               = optional(map(string))<br>      resource_group_name           = optional(string)<br>      location                      = optional(string)<br>      subnet_id                     = optional(string)<br>      custom_network_interface_name = optional(string)<br>      tags                          = optional(map(string))<br>      private_dns_zone_group = optional(object({<br>        name                 = string<br>        custom_metadata      = optional(map(string))<br>        private_dns_zone_ids = list(string)<br>      }))<br>      private_service_connection = optional(object({<br>        name                              = string<br>        custom_metadata                   = optional(map(string))<br>        is_manual_connection              = bool<br>        private_connection_resource_id    = optional(string)<br>        private_connection_resource_alias = optional(string)<br>        subresource_names                 = optional(list(string))<br>        request_message                   = optional(string)<br>      }))<br>      ip_configuration = optional(list(object({<br>        name               = string<br>        custom_metadata    = optional(map(string))<br>        private_ip_address = string<br>        subresource_name   = optional(string)<br>        member_name        = optional(string)<br>      })))<br>    })))<br>  }))</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_subnet                  = optional(map(any))<br>    azure_log_analytics_workspace = optional(map(any))<br>    azure_storage_account         = optional(map(any))<br>    azure_private_dns_zone        = optional(map(any))<br>    azure_resource_group          = optional(map(any))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_key_vault"></a> [azure\_key\_vault](#output\_azure\_key\_vault) | Azure Key vaults |
<!-- END_TF_DOCS -->