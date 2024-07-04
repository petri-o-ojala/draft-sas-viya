#
# Azure Database - PostgreSQL
#

locals {
  azurerm_postgresql_server = azurerm_postgresql_server.lz
}

resource "azurerm_postgresql_server" "lz" {
  for_each = {
    for db in local.azure_postgresql_server : db.resource_index => db
  }

  name                    = each.value.name
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  sku_name                = each.value.sku_name
  version                 = each.value.version
  ssl_enforcement_enabled = each.value.ssl_enforcement_enabled

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  administrator_login               = each.value.administrator_login
  administrator_login_password      = each.value.administrator_login_password
  auto_grow_enabled                 = each.value.auto_grow_enabled
  backup_retention_days             = each.value.backup_retention_days
  create_mode                       = each.value.create_mode
  creation_source_server_id         = each.value.creation_source_server_id
  geo_redundant_backup_enabled      = each.value.geo_redundant_backup_enabled
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  public_network_access_enabled     = each.value.public_network_access_enabled
  restore_point_in_time             = each.value.restore_point_in_time
  ssl_minimal_tls_version_enforced  = each.value.ssl_minimal_tls_version_enforced
  storage_mb                        = each.value.storage_mb

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type = each.value.identity.type
    }
  }

  dynamic "threat_detection_policy" {
    # (Optional) Threat detection policy configuration, known in the API as Server Security Alerts Policy. 
    for_each = try(each.value.threat_detection_policy, null) == null ? [] : [1]

    content {
      enabled                    = each.value.threat_detection_policy.enabled
      disabled_alerts            = each.value.threat_detection_policy.disabled_alerts
      email_account_admins       = each.value.threat_detection_policy.email_account_admins
      email_addresses            = each.value.threat_detection_policy.email_addresses
      retention_days             = each.value.threat_detection_policy.retention_days
      storage_account_access_key = each.value.threat_detection_policy.storage_account_access_key
      storage_endpoint           = each.value.threat_detection_policy.storage_endpoint
    }

  }

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_postgresql_virtual_network_rule" "lz" {
  for_each = {
    for rule in local.azure_postgresql_virtual_network_rule : rule.resource_index => rule
  }

  name                                 = each.value.name
  resource_group_name                  = each.value.resource_group_name
  server_name                          = each.value.server_name
  subnet_id                            = lookup(local.azure_subnet, each.value.subnet_id, null) == null ? each.value.subnet_id : local.azure_subnet[each.value.subnet_id].id
  ignore_missing_vnet_service_endpoint = each.value.ignore_missing_vnet_service_endpoint

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_postgresql_active_directory_administrator" "lz" {
  for_each = {
    for admin in local.azure_postgresql_active_directory_administrator : admin.resource_index => admin
  }

  server_name         = each.value.server_name
  resource_group_name = each.value.resource_group_name
  login               = each.value.login
  tenant_id           = each.value.tenant_id
  object_id           = each.value.object_id

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_management_lock" "azurerm_postgresql" {
  for_each = {
    for db in local.azure_postgresql_server : db.resource_index => db
    if db.management_lock != null
  }

  name       = coalesce(each.value.management_lock.name, each.value.name)
  scope      = azurerm_postgresql_server.lz[each.key].id
  lock_level = coalesce(each.value.management_lock.lock_level, "CanNotDelete")
  notes      = each.value.management_lock.notes
}

resource "azurerm_postgresql_firewall_rule" "lz" {
  for_each = {
    for rule in local.azure_postgresql_firewall_rule : rule.resource_index => rule
  }

  name                = each.value.name
  server_name         = each.value.server_name
  resource_group_name = each.value.resource_group_name
  start_ip_address    = each.value.start_ip_address
  end_ip_address      = each.value.end_ip_address
}

resource "azurerm_postgresql_database" "lz" {
  for_each = {
    for db in local.azure_postgresql_database : db.resource_index => db
  }

  name                = each.value.name
  server_name         = each.value.server_name
  resource_group_name = each.value.resource_group_name
  charset             = each.value.charset
  collation           = each.value.collation

  timeouts {
    # Default for all resources
    create = "15m"
    delete = "15m"
  }
}
