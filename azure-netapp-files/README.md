<!-- BEGIN_TF_DOCS -->

Azure NetApp Files

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
| [azurerm_netapp_account.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account) | resource |
| [azurerm_netapp_account_encryption.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account_encryption) | resource |
| [azurerm_netapp_pool.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool) | resource |
| [azurerm_netapp_volume.lz](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_anf"></a> [anf](#input\_anf) | Azure Container Registry | <pre>object({<br>    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account<br>    account = optional(map(object({<br>      name                = string<br>      resource_group_name = string<br>      location            = string<br>      tags                = optional(map(string))<br>      active_directory = optional(object({<br>        dns_servers                       = list(string)<br>        domain                            = string<br>        smb_server_name                   = string<br>        username                          = string<br>        password                          = string<br>        organizational_unit               = optional(string)<br>        site_name                         = optional(string)<br>        kerberos_ad_name                  = optional(string)<br>        kerberos_kdc_ip                   = optional(string)<br>        aes_encryption_enabled            = optional(bool)<br>        local_nfs_users_with_ldap_allowed = optional(bool)<br>        ldap_over_tls_enabled             = optional(bool)<br>        server_root_ca_certificate        = optional(string)<br>        ldap_signing_enabled              = optional(bool)<br>      }))<br>      identity = optional(object({<br>        type         = string<br>        identity_ids = optional(string)<br>      }))<br>      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account_encryption<br>      encryption = optional(object({<br>        encryption_key                        = string<br>        netapp_account_id                     = optional(string)<br>        system_assigned_identity_principal_id = optional(string)<br>        user_assigned_identity_id             = optional(string)<br>      }))<br>    })))<br>    pool = optional(map(object({<br>      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool<br>      name                = string<br>      resource_group_name = optional(string)<br>      location            = optional(string)<br>      account_name        = string<br>      tags                = optional(map(string))<br>      service_level       = string<br>      size_in_tb          = number<br>      qos_type            = optional(string)<br>      encryption_type     = optional(string)<br>    })))<br>    volume = optional(map(object({<br>      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume<br>      name                                 = string<br>      resource_group_name                  = optional(string)<br>      location                             = optional(string)<br>      account_name                         = string<br>      pool_name                            = string<br>      tags                                 = optional(map(string))<br>      zone                                 = optional(string)<br>      volume_path                          = string<br>      service_level                        = string<br>      azure_vmware_data_store_enabled      = optional(bool)<br>      protocols                            = optional(list(string))<br>      security_style                       = optional(string)<br>      subnet_id                            = string<br>      network_features                     = optional(string)<br>      storage_quota_in_gb                  = string<br>      snapshot_directory_visible           = optional(bool)<br>      create_from_snapshot_resource_id     = optional(string)<br>      throughput_in_mibps                  = optional(number)<br>      encryption_key_source                = optional(string)<br>      kerberos_enabled                     = optional(bool)<br>      key_vault_private_endpoint_id        = optional(string)<br>      smb_non_browsable_enabled            = optional(bool)<br>      smb_access_based_enumeration_enabled = optional(bool)<br>      smb_continuous_availability_enabled  = optional(bool)<br>      data_protection_replication = optional(object({<br>        endpoint_type             = optional(string)<br>        remote_volume_location    = string<br>        remote_volume_resource_id = string<br>        replication_frequency     = string<br>      }))<br>      data_protection_snapshot_policy = optional(object({<br>        snapshot_policy_id = string<br>      }))<br>      export_policy_rule = optional(list(object({<br>        rule_index                     = number<br>        allowed_clients                = list(string)<br>        protocols_enabled              = optional(list(string))<br>        unix_read_only                 = optional(bool)<br>        unix_read_write                = optional(bool)<br>        root_access_enabled            = optional(bool)<br>        kerberos_5_read_only_enabled   = optional(bool)<br>        kerberos_5_read_write_enabled  = optional(bool)<br>        kerberos_5i_read_only_enabled  = optional(bool)<br>        kerberos_5i_read_write_enabled = optional(bool)<br>        kerberos_5p_read_only_enabled  = optional(bool)<br>        kerberos_5p_read_write_enabled = optional(bool)<br>      })))<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_common"></a> [common](#input\_common) | Common Azure resource parameters | <pre>object({<br>    tags            = optional(map(string))<br>    custom_metadata = optional(map(string))<br>  })</pre> | `{}` | no |
| <a name="input_entra_id"></a> [entra\_id](#input\_entra\_id) | Entra ID configuration | <pre>object({<br>    alias = optional(map(string), {})<br>  })</pre> | <pre>{<br>  "alias": {}<br>}</pre> | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Azure Resource references | <pre>object({<br>    azure_subnet                  = optional(map(any))<br>    azure_log_analytics_workspace = optional(map(any))<br>    azure_storage_account         = optional(map(any))<br>    azure_private_dns_zone        = optional(map(any))<br>    azure_resource_group          = optional(map(any))<br>    azure_role_definition         = optional(map(any))<br>    azure_resource_principal_id   = optional(map(any))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azure_netapp_account"></a> [azure\_netapp\_account](#output\_azure\_netapp\_account) | Azure NetApp Files Accounts |
<!-- END_TF_DOCS -->