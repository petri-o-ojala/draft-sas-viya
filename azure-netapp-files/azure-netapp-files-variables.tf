#
# Azure NetApp Files
#

variable "anf" {
  description = "Azure Container Registry"
  type = object({
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account
    account = optional(map(object({
      name                = string
      resource_group_name = string
      location            = string
      tags                = optional(map(string))
      active_directory = optional(object({
        dns_servers                       = list(string)
        domain                            = string
        smb_server_name                   = string
        username                          = string
        password                          = string
        organizational_unit               = optional(string)
        site_name                         = optional(string)
        kerberos_ad_name                  = optional(string)
        kerberos_kdc_ip                   = optional(string)
        aes_encryption_enabled            = optional(bool)
        local_nfs_users_with_ldap_allowed = optional(bool)
        ldap_over_tls_enabled             = optional(bool)
        server_root_ca_certificate        = optional(string)
        ldap_signing_enabled              = optional(bool)
      }))
      identity = optional(object({
        type         = string
        identity_ids = optional(string)
      }))
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account_encryption
      encryption = optional(object({
        encryption_key                        = string
        netapp_account_id                     = optional(string)
        system_assigned_identity_principal_id = optional(string)
        user_assigned_identity_id             = optional(string)
      }))
    })))
    pool = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool
      name                = string
      resource_group_name = optional(string)
      location            = optional(string)
      account_name        = string
      tags                = optional(map(string))
      service_level       = string
      size_in_tb          = number
      qos_type            = optional(string)
      encryption_type     = optional(string)
    })))
    volume = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume
      name                                 = string
      resource_group_name                  = optional(string)
      location                             = optional(string)
      account_name                         = string
      pool_name                            = string
      tags                                 = optional(map(string))
      zone                                 = optional(string)
      volume_path                          = string
      service_level                        = string
      azure_vmware_data_store_enabled      = optional(bool)
      protocols                            = optional(list(string))
      security_style                       = optional(string)
      subnet_id                            = string
      network_features                     = optional(string)
      storage_quota_in_gb                  = string
      snapshot_directory_visible           = optional(bool)
      create_from_snapshot_resource_id     = optional(string)
      throughput_in_mibps                  = optional(number)
      encryption_key_source                = optional(string)
      kerberos_enabled                     = optional(bool)
      key_vault_private_endpoint_id        = optional(string)
      smb_non_browsable_enabled            = optional(bool)
      smb_access_based_enumeration_enabled = optional(bool)
      smb_continuous_availability_enabled  = optional(bool)
      data_protection_replication = optional(object({
        endpoint_type             = optional(string)
        remote_volume_location    = string
        remote_volume_resource_id = string
        replication_frequency     = string
      }))
      data_protection_snapshot_policy = optional(object({
        snapshot_policy_id = string
      }))
      export_policy_rule = optional(list(object({
        rule_index                     = number
        allowed_clients                = list(string)
        protocols_enabled              = optional(list(string))
        unix_read_only                 = optional(bool)
        unix_read_write                = optional(bool)
        root_access_enabled            = optional(bool)
        kerberos_5_read_only_enabled   = optional(bool)
        kerberos_5_read_write_enabled  = optional(bool)
        kerberos_5i_read_only_enabled  = optional(bool)
        kerberos_5i_read_write_enabled = optional(bool)
        kerberos_5p_read_only_enabled  = optional(bool)
        kerberos_5p_read_write_enabled = optional(bool)
      })))
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume_quota_rule
      quota_rule = optional(list(object({
        name              = string
        location          = string
        quota_size_in_kib = number
        quota_type        = string
        quota_target      = optional(number)
      })))
    })))
  })
  default = {}
}

locals {
  anf = var.anf

  #
  # Principal IDs
  #
  azure_principal_id = merge(
    local.entra_id_alias,
    {
      for resource_id, principal_id in local.azure_resource_principal_id : resource_id => principal_id
    }
  )

  #
  # Azure NetApp Files
  #
  azure_netapp_account = flatten([
    for account_id, account in coalesce(try(local.anf.account, null), {}) : merge(
      account,
      {
        resource_index = join("_", [account_id])
      }
    )
  ])

  azure_netapp_account_encryption = flatten([
    for account_id, account in coalesce(try(local.anf.account, null), {}) : merge(
      account.encryption,
      {
        account_name   = azurerm_netapp_account.lz[account_id].id
        resource_index = join("_", [account_id])
      }
    )
    if account.encryption != null
  ])

  azure_netapp_pool = flatten([
    for pool_id, pool in coalesce(try(local.anf.pool, null), {}) : merge(
      pool,
      {
        account_name        = lookup(local.azurerm_netapp_account, pool.account_name, null) == null ? pool.account_name : azurerm_netapp_account.lz[pool.account_name].name
        resource_group_name = lookup(local.azurerm_netapp_account, pool.account_name, null) == null ? pool.resource_group_name : azurerm_netapp_account.lz[pool.account_name].resource_group_name
        location            = lookup(local.azurerm_netapp_account, pool.account_name, null) == null ? pool.location : azurerm_netapp_account.lz[pool.account_name].location
        resource_index      = join("_", [pool_id])
      }
    )
  ])

  azure_netapp_volume = flatten([
    for volume_id, volume in coalesce(try(local.anf.volume, null), {}) : merge(
      volume,
      {
        account_name        = lookup(local.azurerm_netapp_account, volume.account_name, null) == null ? volume.account_name : azurerm_netapp_account.lz[volume.account_name].name
        pool_name           = lookup(local.azurerm_netapp_pool, volume.pool_name, null) == null ? volume.pool_name : azurerm_netapp_pool.lz[volume.pool_name].name
        resource_group_name = lookup(local.azurerm_netapp_pool, volume.pool_name, null) == null ? volume.resource_group_name : azurerm_netapp_pool.lz[volume.pool_name].resource_group_name
        location            = lookup(local.azurerm_netapp_pool, volume.pool_name, null) == null ? volume.location : azurerm_netapp_pool.lz[volume.pool_name].location
        resource_index      = join("_", [volume_id])
      }
    )
  ])

  azure_netapp_volume_quota_rule = flatten([
    for volume_id, volume in coalesce(try(local.anf.volume, null), {}) : [
      for rule in coalesce(try(volume.quota_rule, null), []) : merge(
        rule,
        {
          volume_id      = azurerm_netapp_volume.lz[volume_id].id
          resource_index = join("_", [volume_id, rule.name])
        }
      )
    ]
  ])
}
