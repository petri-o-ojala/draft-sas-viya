#
# Azure Network Watcher Flow Logs
#

locals {
  azurerm_network_watcher_flow_log = azurerm_network_watcher_flow_log.lz
}

resource "azurerm_network_watcher_flow_log" "lz" {
  for_each = {
    for flow_log in local.azure_network_watcher_flow_log : flow_log.resource_index => flow_log
  }

  name                      = each.value.name
  network_watcher_name      = each.value.network_watcher_name
  resource_group_name       = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location                  = each.value.location == null ? each.value.location : lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location
  network_security_group_id = lookup(local.azurerm_network_security_group, each.value.network_security_group_id, null) ? each.value.network_security_group_id : local.azurerm_network_security_group[each.value.network_security_group_id].id
  storage_account_id        = lookup(local.azure_storage_account, each.value.storage_account_id, null) == null ? each.value.storage_account_id : local.azure_storage_account[each.value.storage_account_id].id
  enabled                   = each.value.enabled
  version                   = each.value.version
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  dynamic "retention_policy" {
    for_each = try(each.value.retention_policy, null) == null ? [] : [1]

    content {
      enabled = each.value.retention_policy.enabled
      days    = each.value.retention_policy.days
    }
  }

  dynamic "traffic_analytics" {
    for_each = try(each.value.traffic_analytics, null) == null ? [] : [1]

    content {
      enabled               = each.value.traffic_analytics.enabled
      workspace_id          = lookup(local.azure_log_analytics_workspace, each.value.traffic_analytics.workspace_id, null) == null ? each.value.traffic_analytics.workspace_id : local.azure_log_analytics_workspace[each.value.traffic_analytics.workspace_id].workspace_id
      workspace_region      = lookup(local.azure_log_analytics_workspace, each.value.traffic_analytics.workspace_region, null) == null ? each.value.traffic_analytics.workspace_region : local.azure_log_analytics_workspace[each.value.traffic_analytics.workspace_region].location
      workspace_resource_id = lookup(local.azure_log_analytics_workspace, each.value.traffic_analytics.workspace_resource_id, null) == null ? each.value.traffic_analytics.workspace_resource_id : local.azure_log_analytics_workspace[each.value.traffic_analytics.workspace_resource_id].id
      interval_in_minutes   = each.value.traffic_analytics.interval_in_minutes
    }
  }
}
