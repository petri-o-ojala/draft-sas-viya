#
# Azure Database - PostgreSQL Flexible
# 

locals {
  azurerm_postgresql_flexible_server = azurerm_postgresql_flexible_server.lz
}

resource "azurerm_postgresql_flexible_server" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server
  for_each = {
    for db in local.azure_postgresql_flexible_server : db.resource_index => db
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  administrator_login          = each.value.administrator_login
  administrator_password       = each.value.administrator_password
  backup_retention_days        = each.value.backup_retention_days
  geo_redundant_backup_enabled = each.value.geo_redundant_backup_enabled
  create_mode                  = each.value.create_mode
  delegated_subnet_id          = lookup(local.azure_subnet, each.value.delegated_subnet_id, null) == null ? each.value.delegated_subnet_id : local.azure_subnet[each.value.delegated_subnet_id].id
  private_dns_zone_id          = lookup(local.azure_private_dns_zone, each.value.private_dns_zone_id, null) == null ? each.value.private_dns_zone_id : local.azure_private_dns_zone[each.value.private_dns_zone_id].id

  public_network_access_enabled     = each.value.public_network_access_enabled
  point_in_time_restore_time_in_utc = each.value.point_in_time_restore_time_in_utc
  replication_role                  = each.value.replication_role
  sku_name                          = each.value.sku_name
  source_server_id                  = each.value.source_server_id
  auto_grow_enabled                 = each.value.auto_grow_enabled
  storage_mb                        = each.value.storage_mb
  storage_tier                      = each.value.storage_tier
  version                           = each.value.version
  zone                              = each.value.zone

  dynamic "authentication" {
    for_each = try(each.value.authentication, null) == null ? [] : [1]

    content {
      active_directory_auth_enabled = each.value.authentication.active_directory_auth_enabled
      password_auth_enabled         = each.value.authentication.password_auth_enabled
      tenant_id                     = each.value.authentication.tenant_id
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(each.value.customer_managed_key, null) == null ? [] : [1]

    content {
      key_vault_key_id                     = each.value.customer_managed_key.key_vault_key_id
      primary_user_assigned_identity_id    = each.value.customer_managed_key.primary_user_assigned_identity_id
      geo_backup_key_vault_key_id          = each.value.customer_managed_key.geo_backup_key_vault_key_id
      geo_backup_user_assigned_identity_id = each.value.customer_managed_key.geo_backup_user_assigned_identity_id
    }
  }

  dynamic "high_availability" {
    for_each = try(each.value.high_availability, null) == null ? [] : [1]

    content {
      mode                      = each.value.high_availability.mode
      standby_availability_zone = each.value.high_availability.standby_availability_zone
    }
  }

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "maintenance_window" {
    for_each = try(each.value.maintenance_window, null) == null ? [] : [1]

    content {
      day_of_week  = each.value.maintenance_window.day_of_week
      start_hour   = each.value.maintenance_window.start_hour
      start_minute = each.value.maintenance_window.start_minute
    }
  }
}
resource "azurerm_postgresql_flexible_server_configuration" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration
  for_each = {
    for configuration in local.azure_postgresql_flexible_server_configuration : configuration.resource_index => configuration
  }

  name      = each.value.name
  server_id = each.value.server_id
  value     = each.value.value
}

resource "azurerm_postgresql_flexible_server_firewall_rule" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule 
  for_each = {
    for rule in local.azure_postgresql_flexible_server_firewall_rule : rule.resource_index => rule
  }

  name             = each.value.name
  server_id        = each.value.server_id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}
