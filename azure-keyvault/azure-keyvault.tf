#
# Azure Key vault
#

locals {
  azurerm_key_vault = merge(
    local.azure_key_vault_reference,
    azurerm_key_vault.lz
  )
}

resource "azurerm_key_vault" "lz" {
  for_each = {
    for vault in local.azure_key_vault : vault.resource_index => vault
  }

  name                = each.value.name
  resource_group_name = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location
  sku_name            = each.value.sku_name
  tenant_id           = each.value.tenant_id
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  enabled_for_deployment          = each.value.enabled_for_deployment
  enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption
  enabled_for_template_deployment = each.value.enabled_for_template_deployment
  enable_rbac_authorization       = each.value.enable_rbac_authorization
  purge_protection_enabled        = each.value.purge_protection_enabled
  public_network_access_enabled   = each.value.public_network_access_enabled
  soft_delete_retention_days      = each.value.soft_delete_retention_days

  dynamic "network_acls" {
    for_each = try(each.value.network_acls, null) == null ? [] : [1]

    content {
      bypass         = each.value.network_acls.bypass
      default_action = each.value.network_acls.default_action
      ip_rules       = each.value.network_acls.ip_rules
      virtual_network_subnet_ids = each.value.network_acls.virtual_network_subnet_ids == null ? null : [
        for id in each.value.network_acls.virtual_network_subnet_ids : lookup(local.azure_subnet, id, null) == null ? id : local.azure_subnet[id].id
      ]
    }
  }

  dynamic "contact" {
    for_each = try(each.value.contact, null) == null ? [] : [1]

    content {
      email = each.value.contact.email
      name  = each.value.contact.name
      phone = each.value.contact.phone
    }
  }
}

resource "azurerm_management_lock" "key_vault" {
  for_each = {
    for vault in local.azure_key_vault : vault.resource_index => vault
    if vault.management_lock != null
  }

  name = templatestring(coalesce(each.value.management_lock.name, each.value.name), merge(
    local.common.custom_metadata,
    each.value.custom_metadata
  ))
  scope      = local.azurerm_key_vault[each.key].id
  lock_level = each.value.management_lock.lock_level
  notes      = each.value.management_lock.notes
}


resource "azurerm_monitor_diagnostic_setting" "key_vault" {
  for_each = {
    for vault in local.azure_key_vault : vault.resource_index => vault
    if vault.diagnostic_setting != null
  }

  name = templatestring(coalesce(each.value.diagnostic_setting.name, each.value.name), merge(
    local.common.custom_metadata,
    each.value.custom_metadata
  ))
  target_resource_id             = local.azurerm_key_vault[each.key].id
  eventhub_name                  = each.value.diagnostic_setting.eventhub_name
  eventhub_authorization_rule_id = each.value.diagnostic_setting.eventhub_authorization_rule_id
  log_analytics_workspace_id     = each.value.diagnostic_setting.log_analytics_workspace_id == null ? null : lookup(local.azure_log_analytics_workspace, each.value.diagnostic_setting.log_analytics_workspace_id, null) == null ? each.value.diagnostic_setting.log_analytics_workspace_id : local.azure_log_analytics_workspace[each.value.diagnostic_setting.log_analytics_workspace_id].id
  storage_account_id             = each.value.diagnostic_setting.storage_account_id == null ? null : lookup(local.azure_storage_account, each.value.diagnostic_setting.storage_account_id, null) == null ? each.value.diagnostic_setting.storage_account_id : local.azure_storage_account[each.value.diagnostic_setting.storage_account_id].id
  log_analytics_destination_type = each.value.diagnostic_setting.log_analytics_destination_type
  partner_solution_id            = each.value.diagnostic_setting.partner_solution_id

  dynamic "enabled_log" {
    for_each = coalesce(each.value.diagnostic_setting.enabled_log, [])

    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group
    }
  }

  dynamic "metric" {
    for_each = coalesce(each.value.diagnostic_setting.metric, [])

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
    }
  }
}

resource "azurerm_private_endpoint" "keyvault" {
  for_each = {
    for vault in local.azure_key_vault_private_endpoint : vault.resource_index => vault
  }

  name                = each.value.private_endpoint.name
  resource_group_name = lookup(local.azure_resource_group, each.value.private_endpoint.resource_group_name, null) == null ? each.value.private_endpoint.resource_group_name : local.azure_resource_group[each.value.private_endpoint.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.private_endpoint.resource_group_name, null) == null ? each.value.private_endpoint.location : local.azure_resource_group[each.value.private_endpoint.resource_group_name].location
  subnet_id           = lookup(local.azure_subnet, each.value.private_endpoint.subnet_id, null) == null ? each.value.private_endpoint.subnet_id : local.azure_subnet[each.value.private_endpoint.subnet_id].id

  custom_network_interface_name = each.value.private_endpoint.custom_network_interface_name
  tags = merge(
    each.value.private_endpoint.tags,
    local.common.tags
  )

  dynamic "private_dns_zone_group" {
    for_each = try(each.value.private_endpoint.private_dns_zone_group, null) == null ? [] : [1]

    content {
      name = templatestring(each.value.private_endpoint.private_dns_zone_group.name, merge(
        local.common.custom_metadata,
        each.value.custom_metadata,
        each.value.private_endpoint.private_dns_zone_group.custom_metadata
      ))
      private_dns_zone_ids = each.value.private_endpoint.private_dns_zone_group.private_dns_zone_ids == null ? null : [
        for id in each.value.private_endpoint.private_dns_zone_group.private_dns_zone_ids : lookup(local.azure_private_dns_zone, id, null) == null ? id : local.azure_private_dns_zone[id].id
      ]
    }
  }

  dynamic "private_service_connection" {
    for_each = try(each.value.private_endpoint.private_service_connection, null) == null ? [] : [1]

    content {
      name = templatestring(each.value.private_endpoint.private_service_connection.name, merge(
        local.common.custom_metadata,
        each.value.custom_metadata,
        each.value.private_endpoint.private_service_connection.custom_metadata
      ))
      is_manual_connection              = each.value.private_endpoint.private_service_connection.is_manual_connection
      private_connection_resource_id    = coalesce(each.value.private_endpoint.private_service_connection.private_connection_resource_id, local.azurerm_key_vault[each.value.keyvault_resource_index].id)
      private_connection_resource_alias = each.value.private_endpoint.private_service_connection.private_connection_resource_alias
      subresource_names                 = each.value.private_endpoint.private_service_connection.subresource_names
      request_message                   = each.value.private_endpoint.private_service_connection.request_message
    }
  }

  dynamic "ip_configuration" {
    for_each = coalesce(each.value.private_endpoint.ip_configuration, [])

    content {
      name = templatestring(ip_configuration.value.name, merge(
        local.common.custom_metadata,
        each.value.custom_metadata,
        ip_configuration.value.custom_metadata
      ))
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = ip_configuration.value.subresource_name
      member_name        = ip_configuration.value.member_name
    }
  }
}

resource "azurerm_role_assignment" "key_vault" {
  for_each = {
    for assignment in local.azure_key_vault_role_assignment : assignment.resource_index => assignment
  }

  name         = each.value.name
  principal_id = lookup(local.azure_principal_id, each.value.principal_id, null) == null ? each.value.principal_id : local.azure_principal_id[each.value.principal_id]
  scope        = each.value.scope

  role_definition_id                     = each.value.role_definition_id == null ? null : lookup(local.azure_role_definition, each.value.role_definition_id, null) == null ? each.value.role_definition_id : local.azure_role_definition[each.value.role_definition_id].id
  role_definition_name                   = each.value.role_definition_name
  principal_type                         = each.value.principal_type
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  description                            = each.value.description
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}
