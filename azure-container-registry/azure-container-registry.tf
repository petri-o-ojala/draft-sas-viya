#
# Azure Container Registry
#

locals {
  azurerm_container_registry = azurerm_container_registry.lz
}

resource "azurerm_container_registry" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
  for_each = {
    for registry in local.azure_container_registry : registry.resource_index => registry
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  sku                           = each.value.sku
  admin_enabled                 = each.value.admin_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  quarantine_policy_enabled     = each.value.quarantine_policy_enabled
  zone_redundancy_enabled       = each.value.zone_redundancy_enabled
  export_policy_enabled         = each.value.export_policy_enabled
  anonymous_pull_enabled        = each.value.anonymous_pull_enabled
  data_endpoint_enabled         = each.value.data_endpoint_enabled
  network_rule_bypass_option    = each.value.network_rule_bypass_option

  dynamic "georeplications" {
    for_each = try(each.value.georeplications, null) == null ? [] : [1]

    content {
      location                  = each.value.georeplications.location
      regional_endpoint_enabled = each.value.georeplications.regional_endpoint_enabled
      zone_redundancy_enabled   = each.value.georeplications.zone_redundancy_enabled
      tags                      = each.value.georeplications.tags
    }
  }

  dynamic "network_rule_set" {
    for_each = try(each.value.network_rule_set, null) == null ? [] : [1]

    content {
      default_action = each.value.network_rule_set.default_action

      dynamic "ip_rule" {
        for_each = coalesce(each.value.network_rule_set.ip_rule, [])

        content {
          action   = ip_rule.value.action
          ip_range = ip_rule.value.ip_range
        }
      }
    }
  }

  dynamic "retention_policy" {
    for_each = try(each.value.retention_policy, null) == null ? [] : [1]

    content {
      days    = each.value.retention_policy.enabled
      enabled = each.value.retention_policy.enabled
    }
  }

  dynamic "trust_policy" {
    for_each = try(each.value.trust_policy, null) == null ? [] : [1]

    content {
      enabled = each.value.trust_policy.enabled
    }
  }

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "encryption" {
    for_each = try(each.value.encryption, null) == null ? [] : [1]

    content {
      key_vault_key_id   = each.value.encryption.key_vault_key_id
      identity_client_id = each.value.encryption.identity_client_id
    }
  }
}

resource "azurerm_management_lock" "container_registry" {
  for_each = {
    for registry in local.azure_container_registry : registry.resource_index => registry
    if registry.management_lock != null
  }

  name = templatestring(coalesce(each.value.management_lock.name, each.value.name), merge(
    local.common.custom_metadata,
    each.value.custom_metadata
  ))
  scope      = local.azurerm_container_registry[each.key].id
  lock_level = each.value.management_lock.lock_level
  notes      = each.value.management_lock.notes
}


resource "azurerm_monitor_diagnostic_setting" "container_registry" {
  for_each = {
    for registry in local.azure_container_registry : registry.resource_index => registry
    if registry.diagnostic_setting != null
  }

  name = templatestring(coalesce(each.value.diagnostic_setting.name, each.value.name), merge(
    local.common.custom_metadata,
    each.value.custom_metadata
  ))
  target_resource_id             = local.azurerm_container_registry[each.key].id
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

resource "azurerm_private_endpoint" "container_registry" {
  for_each = {
    for registry in local.azure_container_registry_private_endpoint : registry.resource_index => registry
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
      private_connection_resource_id    = coalesce(each.value.private_endpoint.private_service_connection.private_connection_resource_id, local.azurerm_container_registry[each.value.container_registry_resource_index].id)
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

resource "azurerm_role_assignment" "container_registry" {
  for_each = {
    for assignment in local.azure_container_registry_role_assignment : assignment.resource_index => assignment
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

resource "azurerm_container_registry_agent_pool" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
  for_each = {
    for pool in local.azure_container_registry_agent_pool : pool.resource_index => pool
  }

  name                    = each.value.name
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  container_registry_name = each.value.container_registry_name
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  instance_count            = each.value.instance_count
  tier                      = each.value.tier
  virtual_network_subnet_id = each.value.virtual_network_subnet_id
}
