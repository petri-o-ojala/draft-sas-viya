#
# Azure Log Analytics
#

locals {
  azurerm_log_analytics_workspace = azurerm_log_analytics_workspace.lz
  azurerm_log_analytics_solution  = azurerm_log_analytics_solution.lz
}

#
# Azure Log Analytics Workspace
#

resource "azurerm_log_analytics_workspace" "lz" {
  for_each = {
    for group in local.azure_log_analytics_workspace : group.resource_index => group
  }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  allow_resource_only_permissions         = each.value.allow_resource_only_permissions
  local_authentication_disabled           = each.value.local_authentication_disabled
  sku                                     = each.value.sku
  retention_in_days                       = each.value.retention_in_days
  cmk_for_query_forced                    = each.value.cmk_for_query_forced
  internet_ingestion_enabled              = each.value.internet_ingestion_enabled
  internet_query_enabled                  = each.value.internet_query_enabled
  reservation_capacity_in_gb_per_day      = each.value.reservation_capacity_in_gb_per_day
  data_collection_rule_id                 = each.value.data_collection_rule_id
  immediate_data_purge_on_30_days_enabled = each.value.immediate_data_purge_on_30_days_enabled
  tags                                    = each.value.tags

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }
}

#
# Azure Log Analytics Workspace Solution
#


resource "azurerm_log_analytics_solution" "lz" {
  for_each = {
    for solution in local.azure_log_analytics_workspace_solution : solution.resource_index => solution
  }

  solution_name       = each.value.solution_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  workspace_resource_id = each.value.workspace_resource_id
  workspace_name        = each.value.workspace_name
  tags                  = each.value.tags

  dynamic "plan" {
    for_each = try(each.value.plan, null) == null ? [] : [1]

    content {
      publisher      = each.value.plan.publisher
      product        = each.value.plan.product
      promotion_code = each.value.plan.promotion_code
    }
  }
}

#
# Azure Log Analytics Workspace Datasources
#

resource "azurerm_log_analytics_datasource_windows_performance_counter" "lz" {
  for_each = {
    for counter in local.azure_log_analytics_workspace_datasource_windows_performance_counter : counter.resource_index => counter
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  workspace_name      = each.value.workspace_name

  object_name      = each.value.object_name
  instance_name    = each.value.instance_name
  counter_name     = each.value.counter_name
  interval_seconds = each.value.interval_seconds
}

resource "azurerm_log_analytics_datasource_windows_event" "lz" {
  for_each = {
    for event in local.azure_log_analytics_workspace_datasource_windows_event : event.resource_index => event
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  workspace_name      = each.value.workspace_name

  event_log_name = each.value.event_log_name
  event_types    = each.value.event_types
}
