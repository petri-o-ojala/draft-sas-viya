<!-- BEGIN_TF_DOCS -->

Azure Messaging services

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
| [azurerm_servicebus_namespace.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_entra_id"></a> [entra\_id](#input\_entra\_id) | Entra ID configuration | <pre>object({<br>    alias = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "alias": {}<br>}</pre> | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_subnet                  = optional(map(any))<br>    azure_log_analytics_workspace = optional(map(any))<br>    azure_storage_account         = optional(map(any))<br>    azure_private_dns_zone        = optional(map(any))<br>    azure_resource_group          = optional(map(any))<br>    azure_role_definition         = optional(map(any))<br>    azure_resource_principal_id   = optional(map(any))<br>  })</pre> | `{}` | no |
| <a name="input_servicebus"></a> [servicebus](#input\_servicebus) | Azure Service Bus | <pre>object({<br>    namespace = optional(object({<br>      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace<br>      name                          = string<br>      resource_group_name           = string<br>      location                      = string<br>      tags                          = optional(map(string))<br>      sku                           = string<br>      capacity                      = optional(number)<br>      local_auth_enabled            = optional(bool)<br>      public_network_access_enabled = optional(bool)<br>      minimum_tls_version           = optional(string)<br>      zone_redundant                = optional(bool)<br>      identity = optional(object({<br>        type         = string<br>        identity_ids = optional(list(string))<br>      }))<br>      customer_managed_key = optional(object({<br>        key_vault_key_id                  = string<br>        identity_id                       = string<br>        infrastructure_encryption_enabled = optional(bool)<br>      }))<br>      network_rule_set = optional(object({<br>        default_action                = optional(string)<br>        public_network_access_enabled = optional(bool)<br>        trusted_services_allowed      = optional(bool)<br>        ip_rules                      = optional(list(string))<br>        network_rules = optional(list(object({<br>          subnet_id                            = string<br>          ignore_missing_vnet_service_endpoint = optional(bool)<br>        })))<br>      }))<br>    }))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_servicebus_namespace"></a> [azure\_servicebus\_namespace](#output\_azure\_servicebus\_namespace) | Azure Service Bus Namespaces |
<!-- END_TF_DOCS -->