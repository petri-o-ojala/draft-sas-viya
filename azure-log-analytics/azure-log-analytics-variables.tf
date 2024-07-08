#
# Azure Log Analytics
#

variable "log_analytics" {
  type = object({
    workspace = optional(map(object({
      name                = string
      location            = string
      resource_group_name = string

      allow_resource_only_permissions         = optional(bool)
      local_authentication_disabled           = optional(bool)
      sku                                     = optional(string)
      retention_in_days                       = optional(number)
      cmk_for_query_forced                    = optional(bool)
      internet_ingestion_enabled              = optional(bool)
      internet_query_enabled                  = optional(bool)
      reservation_capacity_in_gb_per_day      = optional(number)
      data_collection_rule_id                 = optional(string)
      immediate_data_purge_on_30_days_enabled = optional(bool)
      tags                                    = optional(map(string))
      identity = optional(object({
        type         = optional(string)
        identity_ids = optional(list(string))
      }))
      solution = optional(map(object({
        solution_name         = optional(string)
        resource_group_name   = optional(string)
        location              = optional(string)
        workspace_resource_id = optional(string)
        workspace_name        = optional(string)
        tags                  = optional(map(string))
        plan = optional(object({
          publisher      = string
          product        = string
          promotion_code = optional(string)
        }))
      })))
      datasource = optional(object({
        windows_performance_counter = optional(map(object({
          name                = optional(string)
          resource_group_name = optional(string)
          workspace_name      = optional(string)
          object_name         = string
          instance_name       = string
          counter_name        = string
          interval_seconds    = number
        })))
        windows_event = optional(map(object({
          name                     = optional(string)
          resource_group_name      = optional(string)
          workspace_name           = optional(string)
          event_log_name           = string
          instancevent_typese_name = list(string)
        })))
      }))
    })))
  })
  default = {}
}

variable "common" {
  #
  # Common data for all resources
  #
  description = "Common Azure resource parameters"
  type = object({
    tags            = optional(map(string))
    custom_metadata = optional(map(string))
  })
  default = {}
}

locals {
  # Use local variable to allow easier long-term development
  common = var.common

  #
  # Azure Log Analytics Workspaces
  #
  azure_log_analytics_workspace = flatten([
    for workspace_id, workspace in coalesce(try(var.log_analytics.workspace, null), {}) : merge(
      workspace,
      {
        resource_index = join("_", [workspace_id])
      }
    )
  ])

  #
  # Azure Log Analytics Workspace Solutions
  #
  azure_log_analytics_workspace_solution = flatten([
    for workspace_id, workspace in coalesce(try(var.log_analytics.workspace, null), {}) : [
      for solution_id, solution in coalesce(workspace.solution, {}) : merge(
        solution,
        {
          solution_name         = coalesce(solution.solution_name, solution_id)
          resource_group_name   = coalesce(solution.resource_group_name, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].resource_group_name)
          location              = coalesce(solution.location, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].location)
          workspace_resource_id = coalesce(solution.workspace_resource_id, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].id)
          workspace_name        = coalesce(solution.workspace_name, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].name)
          resource_index        = join("_", [workspace_id, solution_id])
        }
      )
    ]
  ])

  #
  # Azure Log Analytics Workspace Datasources
  #
  azure_log_analytics_workspace_datasource_windows_performance_counter = flatten([
    for workspace_id, workspace in coalesce(try(var.log_analytics.workspace, null), {}) : [
      for datasource_id, datasource in coalesce(try(workspace.datasource.windows_performance_counter, null), {}) : merge(
        datasource,
        {
          name                = coalesce(datasource.name, datasource_id)
          resource_group_name = coalesce(datasource.resource_group_name, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].resource_group_name)
          workspace_name      = coalesce(datasource.workspace_name, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].name)
          resource_index      = join("_", [workspace_id, datasource_id])
        }
      )
    ]
  ])

  azure_log_analytics_workspace_datasource_windows_event = flatten([
    for workspace_id, workspace in coalesce(try(var.log_analytics.workspace, null), {}) : [
      for datasource_id, datasource in coalesce(try(workspace.datasource.windows_event, null), {}) : merge(
        datasource,
        {
          name                = coalesce(datasource.name, datasource_id)
          resource_group_name = coalesce(datasource.resource_group_name, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].resource_group_name)
          workspace_name      = coalesce(datasource.workspace_name, local.azurerm_log_analytics_workspace[join("_", [workspace_id])].name)
          resource_index      = join("_", [workspace_id, datasource_id])
        }
      )
    ]
  ])
}
