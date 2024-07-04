#
# Azure NetApp Files
#

locals {
  azurerm_netapp_account = azurerm_netapp_account.lz
  azurerm_netapp_pool    = azurerm_netapp_pool.lz
  azurerm_netapp_volume  = azurerm_netapp_volume.lz
}

resource "azurerm_netapp_account" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account
  for_each = {
    for account in local.azure_netapp_account : account.resource_index => account
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  dynamic "active_directory" {
    for_each = try(each.value.active_directory, null) == null ? [] : [1]

    content {
      dns_servers                       = each.value.active_directory.dns_servers
      domain                            = each.value.active_directory.domain
      smb_server_name                   = each.value.active_directory.smb_server_name
      username                          = each.value.active_directory.username
      password                          = each.value.active_directory.password
      organizational_unit               = each.value.active_directory.organizational_unit
      site_name                         = each.value.active_directory.site_name
      kerberos_ad_name                  = each.value.active_directory.kerberos_ad_name
      kerberos_kdc_ip                   = each.value.active_directory.kerberos_kdc_ip
      aes_encryption_enabled            = each.value.active_directory.aes_encryption_enabled
      local_nfs_users_with_ldap_allowed = each.value.active_directory.local_nfs_users_with_ldap_allowed
      ldap_over_tls_enabled             = each.value.active_directory.ldap_over_tls_enabled
      server_root_ca_certificate        = each.value.active_directory.server_root_ca_certificate
      ldap_signing_enabled              = each.value.active_directory.ldap_signing_enabled
    }
  }

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }
}

resource "azurerm_netapp_account_encryption" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_account_encryption
  for_each = {
    for account in local.azure_netapp_account_encryption : account.resource_index => account
  }

  encryption_key                        = each.value.encryption_key
  netapp_account_id                     = each.value.netapp_account_id
  system_assigned_identity_principal_id = each.value.system_assigned_identity_principal_id
  user_assigned_identity_id             = each.value.user_assigned_identity_id
}

resource "azurerm_netapp_pool" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_pool
  for_each = {
    for pool in local.azure_netapp_pool : pool.resource_index => pool
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  account_name        = each.value.account_name
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  service_level   = each.value.service_level
  size_in_tb      = each.value.size_in_tb
  qos_type        = each.value.qos_type
  encryption_type = each.value.encryption_type
}

resource "azurerm_netapp_volume" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume
  for_each = {
    for volume in local.azure_netapp_volume : volume.resource_index => volume
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  account_name        = each.value.account_name
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  zone                                 = each.value.zone
  volume_path                          = each.value.volume_path
  pool_name                            = each.value.pool_name
  service_level                        = each.value.service_level
  azure_vmware_data_store_enabled      = each.value.azure_vmware_data_store_enabled
  protocols                            = each.value.protocols
  security_style                       = each.value.security_style
  subnet_id                            = each.value.subnet_id
  network_features                     = each.value.network_features
  storage_quota_in_gb                  = each.value.storage_quota_in_gb
  snapshot_directory_visible           = each.value.snapshot_directory_visible
  create_from_snapshot_resource_id     = each.value.create_from_snapshot_resource_id
  throughput_in_mibps                  = each.value.throughput_in_mibps
  encryption_key_source                = each.value.encryption_key_source
  kerberos_enabled                     = each.value.kerberos_enabled
  key_vault_private_endpoint_id        = each.value.key_vault_private_endpoint_id
  smb_non_browsable_enabled            = each.value.smb_non_browsable_enabled
  smb_access_based_enumeration_enabled = each.value.smb_access_based_enumeration_enabled
  smb_continuous_availability_enabled  = each.value.smb_continuous_availability_enabled

  dynamic "data_protection_replication" {
    for_each = try(each.value.data_protection_replication, null) == null ? [] : [1]

    content {
      endpoint_type             = each.value.data_protection_replication.endpoint_type
      remote_volume_location    = each.value.data_protection_replication.remote_volume_location
      remote_volume_resource_id = each.value.data_protection_replication.remote_volume_resource_id
      replication_frequency     = each.value.data_protection_replication.replication_frequency
    }
  }

  dynamic "data_protection_snapshot_policy" {
    for_each = try(each.value.data_protection_snapshot_policy, null) == null ? [] : [1]

    content {
      snapshot_policy_id = each.value.data_protection_snapshot_policy.snapshot_policy_id
    }
  }

  dynamic "export_policy_rule" {
    for_each = try(each.value.export_policy_rule, [])

    content {
      rule_index                     = export_policy_rule.value.rule_index
      allowed_clients                = export_policy_rule.value.allowed_clients
      protocols_enabled              = export_policy_rule.value.protocols_enabled
      unix_read_only                 = export_policy_rule.value.unix_read_only
      unix_read_write                = export_policy_rule.value.unix_read_write
      root_access_enabled            = export_policy_rule.value.root_access_enabled
      kerberos_5_read_only_enabled   = export_policy_rule.value.kerberos_5_read_only_enabled
      kerberos_5_read_write_enabled  = export_policy_rule.value.kerberos_5_read_write_enabled
      kerberos_5i_read_only_enabled  = export_policy_rule.value.kerberos_5i_read_only_enabled
      kerberos_5i_read_write_enabled = export_policy_rule.value.kerberos_5i_read_write_enabled
      kerberos_5p_read_only_enabled  = export_policy_rule.value.kerberos_5p_read_only_enabled
      kerberos_5p_read_write_enabled = export_policy_rule.value.kerberos_5p_read_write_enabled
    }
  }
}

resource "azurerm_netapp_volume_quota_rule" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/netapp_volume_quota_rule
  for_each = {
    for rule in local.azure_netapp_volume_quota_rule : rule.resource_index => rule
  }

  name              = each.value.name
  location          = each.value.location
  volume_id         = each.value.volume_id
  quota_size_in_kib = each.value.quota_size_in_kib
  quota_type        = each.value.quota_type
  quota_target      = each.value.quota_target
}
