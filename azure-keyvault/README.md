<!-- BEGIN_TF_DOCS -->

Azure Keyvault

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_secret.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_management_lock.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |
| [azurerm_monitor_diagnostic_setting.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_private_endpoint.keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [random_password.lz](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_entra_id"></a> [entra\_id](#input\_entra\_id) | Entra ID configuration | <pre>object({<br>    alias = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "alias": {}<br>}</pre> | no |
| <a name="input_keyvault"></a> [keyvault](#input\_keyvault) | Azure Keyvaults | <pre>object({<br>    secret = optional(map(object({<br>      name            = string<br>      custom_metadata = optional(map(string))<br>      tags            = optional(map(string))<br>      value           = optional(string)<br>      key_vault_id    = string<br>      content_type    = optional(string)<br>      not_before_date = optional(string)<br>      expiration_date = optional(string)<br>      random_password = optional(object({<br>        length           = optional(number)<br>        upper            = optional(bool)<br>        min_upper        = optional(number)<br>        lower            = optional(bool)<br>        min_lower        = optional(number)<br>        numeric          = optional(bool)<br>        min_numeric      = optional(number)<br>        special          = optional(bool)<br>        override_special = optional(string)<br>        min_special      = optional(number)<br>      }))<br>    })))<br>    vault = optional(map(object({<br>      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault<br>      name                = string<br>      custom_metadata     = optional(map(string))<br>      resource_group_name = string<br>      location            = optional(string)<br>      sku_name            = string<br>      tenant_id           = string<br>      tags                = optional(map(string))<br>      management_lock = optional(object({<br>        name       = optional(string)<br>        lock_level = optional(string, "CanNotDelete")<br>        notes      = optional(string)<br>      }))<br>      diagnostic_setting = optional(object({<br>        name                           = optional(string)<br>        custom_metadata                = optional(map(string))<br>        eventhub_name                  = optional(string)<br>        eventhub_authorization_rule_id = optional(string)<br>        log_analytics_workspace_id     = optional(string)<br>        storage_account_id             = optional(string)<br>        log_analytics_destination_type = optional(string)<br>        partner_solution_id            = optional(string)<br>        enabled_log = optional(list(object({<br>          category       = optional(string)<br>          category_group = optional(string)<br>          retention_policy = optional(object({<br>            days    = optional(number)<br>            enabled = optional(bool)<br>          }))<br>        })))<br>        metric = optional(list(object({<br>          category = string<br>          enabled  = optional(bool)<br>          retention_policy = optional(object({<br>            days    = optional(number)<br>            enabled = optional(bool)<br>          }))<br>        })))<br>      }))<br>      enabled_for_deployment          = optional(bool)<br>      enabled_for_disk_encryption     = optional(bool)<br>      enabled_for_template_deployment = optional(bool)<br>      enable_rbac_authorization       = optional(bool)<br>      purge_protection_enabled        = optional(bool)<br>      public_network_access_enabled   = optional(bool)<br>      soft_delete_retention_days      = optional(number)<br>      network_acls = optional(object({<br>        bypass                     = string<br>        default_action             = string<br>        ip_rules                   = optional(list(string))<br>        virtual_network_subnet_ids = optional(list(string))<br>      }))<br>      contact = optional(object({<br>        email = string<br>        name  = optional(string)<br>        phone = optional(string)<br>      }))<br>      private_endpoint = optional(list(object({<br>        # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint<br>        name                          = string<br>        custom_metadata               = optional(map(string))<br>        resource_group_name           = optional(string)<br>        location                      = optional(string)<br>        subnet_id                     = optional(string)<br>        custom_network_interface_name = optional(string)<br>        tags                          = optional(map(string))<br>        private_dns_zone_group = optional(object({<br>          name                 = string<br>          custom_metadata      = optional(map(string))<br>          private_dns_zone_ids = list(string)<br>        }))<br>        private_service_connection = optional(object({<br>          name                              = string<br>          custom_metadata                   = optional(map(string))<br>          is_manual_connection              = bool<br>          private_connection_resource_id    = optional(string)<br>          private_connection_resource_alias = optional(string)<br>          subresource_names                 = optional(list(string))<br>          request_message                   = optional(string)<br>        }))<br>        ip_configuration = optional(list(object({<br>          name               = string<br>          custom_metadata    = optional(map(string))<br>          private_ip_address = string<br>          subresource_name   = optional(string)<br>          member_name        = optional(string)<br>        })))<br>      })))<br>      iam = optional(list(object({<br>        name                                   = optional(string)<br>        role_definition_name                   = optional(string)<br>        role_definition_id                     = optional(string)<br>        principal_type                         = optional(string)<br>        scope                                  = optional(string)<br>        principal_id                           = list(string)<br>        condition                              = optional(string)<br>        condition_version                      = optional(string)<br>        delegated_managed_identity_resource_id = optional(string)<br>        description                            = optional(string)<br>        skip_service_principal_aad_check       = optional(bool)<br>      })))<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_subnet                  = optional(map(any))<br>    azure_log_analytics_workspace = optional(map(any))<br>    azure_storage_account         = optional(map(any))<br>    azure_private_dns_zone        = optional(map(any))<br>    azure_resource_group          = optional(map(any))<br>    azure_role_definition         = optional(map(any))<br>    azure_resource_principal_id   = optional(map(any))<br>    azure_key_vault               = optional(map(any))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_key_vault"></a> [azure\_key\_vault](#output\_azure\_key\_vault) | Azure Key vaults |
<!-- END_TF_DOCS -->