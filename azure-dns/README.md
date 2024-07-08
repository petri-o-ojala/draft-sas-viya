<!-- BEGIN_TF_DOCS -->

Azure DNS

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
| [azurerm_dns_a_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_a_record) | resource |
| [azurerm_dns_aaaa_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_aaaa_record) | resource |
| [azurerm_dns_caa_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_caa_record) | resource |
| [azurerm_dns_cname_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_cname_record) | resource |
| [azurerm_dns_mx_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_mx_record) | resource |
| [azurerm_dns_ns_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ns_record) | resource |
| [azurerm_dns_ptr_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_ptr_record) | resource |
| [azurerm_dns_srv_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_srv_record) | resource |
| [azurerm_dns_txt_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_txt_record) | resource |
| [azurerm_dns_zone.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/dns_zone) | resource |
| [azurerm_private_dns_a_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_a_record) | resource |
| [azurerm_private_dns_aaaa_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_aaaa_record) | resource |
| [azurerm_private_dns_cname_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_cname_record) | resource |
| [azurerm_private_dns_mx_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_mx_record) | resource |
| [azurerm_private_dns_ptr_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_ptr_record) | resource |
| [azurerm_private_dns_srv_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_srv_record) | resource |
| [azurerm_private_dns_txt_record.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_txt_record) | resource |
| [azurerm_private_dns_zone.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_role_assignment.private_dns_zone](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_dns"></a> [dns](#input\_dns) | Azure DNS | <pre>object({<br>    zone = optional(map(object({<br>      name                = string<br>      resource_group_name = string<br>      tags                = optional(map(string))<br>      soa_record = optional(object({<br>        email         = string<br>        host_name     = optional(string)<br>        expire_time   = optional(number)<br>        minimum_ttl   = optional(number)<br>        refresh_time  = optional(number)<br>        retry_time    = optional(number)<br>        serial_number = optional(number)<br>        ttl           = optional(number)<br>        tags          = optional(map(string))<br>      }))<br>    })))<br>    record = optional(list(object({<br>      name                = string<br>      resource_group_name = optional(string)<br>      zone_name           = string<br>      type                = string<br>      ttl                 = number<br>      target_resource_id  = optional(string)<br>      tags                = optional(map(string))<br>      # A, AAAA, NS, PTR type<br>      records = optional(list(string))<br>      # CNAME type<br>      cname_record = optional(string)<br>      # CAA type<br>      caa_record = optional(list(object({<br>        flags = number<br>        tag   = string<br>        value = string<br>      })))<br>      # MX type<br>      mx_record = optional(list(object({<br>        preference = number<br>        exchange   = string<br>      })))<br>      # SRV type<br>      srv_record = optional(list(object({<br>        priority = number<br>        weight   = number<br>        port     = number<br>        target   = string<br>      })))<br>      # TXT type<br>      txt_record = optional(list(object({<br>        value = number<br>      })))<br>    })))<br>    private_zone = optional(map(object({<br>      name                = string<br>      resource_group_name = string<br>      tags                = optional(map(string))<br>      soa_record = optional(object({<br>        email         = string<br>        host_name     = optional(string)<br>        expire_time   = optional(number)<br>        minimum_ttl   = optional(number)<br>        refresh_time  = optional(number)<br>        retry_time    = optional(number)<br>        serial_number = optional(number)<br>        ttl           = optional(number)<br>        tags          = optional(map(string))<br>      }))<br>      iam = optional(list(object({<br>        name                                   = optional(string)<br>        role_definition_name                   = optional(string)<br>        role_definition_id                     = optional(string)<br>        principal_type                         = optional(string)<br>        scope                                  = optional(string)<br>        principal_id                           = list(string)<br>        condition                              = optional(string)<br>        condition_version                      = optional(string)<br>        delegated_managed_identity_resource_id = optional(string)<br>        description                            = optional(string)<br>        skip_service_principal_aad_check       = optional(bool)<br>      })))<br>    })))<br>    private_zone_vnet_link = optional(map(object({<br>      name                  = string<br>      private_dns_zone_name = string<br>      resource_group_name   = string<br>      virtual_network_id    = string<br>      registration_enabled  = optional(bool)<br>      tags                  = optional(map(string))<br>    })))<br>    private_record = optional(list(object({<br>      name                = string<br>      resource_group_name = optional(string)<br>      zone_name           = string<br>      type                = string<br>      ttl                 = number<br>      target_resource_id  = optional(string)<br>      tags                = optional(map(string))<br>      # A, AAAA, NS, PTR type<br>      records = optional(list(string))<br>      # CNAME type<br>      cname_record = optional(string)<br>      # CAA type<br>      caa_record = optional(list(object({<br>        flags = number<br>        tag   = string<br>        value = string<br>      })))<br>      # MX type<br>      mx_record = optional(list(object({<br>        preference = number<br>        exchange   = string<br>      })))<br>      # SRV type<br>      srv_record = optional(list(object({<br>        priority = number<br>        weight   = number<br>        port     = number<br>        target   = string<br>      })))<br>      # TXT type<br>      txt_record = optional(list(object({<br>        value = number<br>      })))<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_entra_id"></a> [entra\_id](#input\_entra\_id) | Entra ID configuration | <pre>object({<br>    alias = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "alias": {}<br>}</pre> | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_resource_group        = optional(map(any))<br>    azure_virtual_network       = optional(map(any))<br>    azure_role_definition       = optional(map(any))<br>    azure_resource_principal_id = optional(map(any))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_dns_zone"></a> [azure\_dns\_zone](#output\_azure\_dns\_zone) | Azure DNS Public Zones |
| <a name="output_azure_private_dns_zone"></a> [azure\_private\_dns\_zone](#output\_azure\_private\_dns\_zone) | Azure DNS Private Zones |
<!-- END_TF_DOCS -->