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
| [azurerm_network_security_group.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_network_security"></a> [network\_security](#input\_network\_security) | Azure Network Security Groups | <pre>object({<br>    group = optional(map(object({<br>      name                = string<br>      resource_group_name = string<br>      location            = string<br>      tags                = optional(map(string))<br>      security_rule = optional(list(object({<br>        description                                = optional(string)<br>        protocol                                   = string<br>        source_port_range                          = optional(string)<br>        source_port_ranges                         = optional(list(string))<br>        destination_port_range                     = optional(string)<br>        destination_port_ranges                    = optional(list(string))<br>        source_address_prefix                      = optional(string)<br>        source_address_prefixes                    = optional(list(string))<br>        source_application_security_group_ids      = optional(list(string))<br>        destination_address_prefix                 = optional(string)<br>        destination_address_prefixes               = optional(list(string))<br>        destination_application_security_group_ids = optional(list(string))<br>        access                                     = string<br>        priority                                   = number<br>        direction                                  = string<br>      })))<br>    })))<br>    rule = optional(map(object({<br>      name                                       = string<br>      resource_group_name                        = string<br>      network_security_group_name                = string<br>      location                                   = string<br>      description                                = optional(string)<br>      protocol                                   = string<br>      source_port_range                          = optional(string)<br>      source_port_ranges                         = optional(list(string))<br>      destination_port_range                     = optional(string)<br>      destination_port_ranges                    = optional(list(string))<br>      source_address_prefix                      = optional(string)<br>      source_address_prefixes                    = optional(list(string))<br>      source_application_security_group_ids      = optional(list(string))<br>      destination_address_prefix                 = optional(string)<br>      destination_address_prefixes               = optional(list(string))<br>      destination_application_security_group_ids = optional(list(string))<br>      access                                     = string<br>      priority                                   = number<br>      direction                                  = string<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_network_security_group"></a> [azure\_network\_security\_group](#output\_azure\_network\_security\_group) | Azure Network Security Groups |
<!-- END_TF_DOCS -->