<!-- BEGIN_TF_DOCS -->

Azure VNet Networking

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
| [azurerm_subnet.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azurerm_virtual_network_dns_servers.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_dns_servers) | resource |
| [azurerm_virtual_network_peering.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_network"></a> [network](#input\_network) | Azure VNet Networking | <pre>object({<br>    vnet = optional(map(object({<br>      name                    = string<br>      custom_metadata         = optional(map(string))<br>      resource_group_name     = string<br>      location                = string<br>      address_space           = list(string)<br>      tags                    = optional(map(string))<br>      bgp_community           = optional(string)<br>      edge_zone               = optional(string)<br>      dns_servers             = optional(list(string))<br>      flow_timeout_in_minutes = optional(number)<br>      ddos_protection_plan = optional(object({<br>        id     = string<br>        enable = bool<br>      }))<br>      encryption = optional(object({<br>        enforcement = string<br>      }))<br>      subnet = optional(map(object({<br>        name                 = optional(string)<br>        custom_metadata      = optional(map(string))<br>        resource_group_name  = optional(string)<br>        virtual_network_name = optional(string)<br>        address_prefixes     = list(string)<br>        delegation = optional(list(object({<br>          name = string<br>          service_delegation = object({<br>            name    = string<br>            actions = optional(list(string))<br>          })<br>        })))<br>        private_endpoint_network_policies             = optional(bool)<br>        private_link_service_network_policies_enabled = optional(bool)<br>        service_endpoints                             = optional(list(string))<br>        service_endpoint_policy_ids                   = optional(list(string))<br>        network_security_group                        = optional(list(string))<br>      })))<br>      peering = optional(map(object({<br>        name                         = string<br>        custom_metadata              = optional(map(string))<br>        virtual_network_name         = optional(string)<br>        remote_virtual_network_id    = optional(string)<br>        resource_group_name          = optional(string)<br>        allow_virtual_network_access = optional(bool)<br>        allow_forwarded_traffic      = optional(bool)<br>        allow_gateway_transit        = optional(bool)<br>        use_remote_gateways          = optional(bool)<br>        triggers                     = optional(map(string))<br>      })))<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_network_security_group = optional(map(any))<br>    azure_resource_group         = optional(map(any))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_subnet"></a> [azure\_subnet](#output\_azure\_subnet) | Azure VNet Subnets |
| <a name="output_azure_virtual_network"></a> [azure\_virtual\_network](#output\_azure\_virtual\_network) | Azure VNet Networks |
<!-- END_TF_DOCS -->