#
# Azure Network Security Groups
#

variable "network_security" {
  description = "Azure Network Security Groups"
  type = object({
    flow_log = optional(map(object({
      name                      = string
      network_watcher_name      = string
      resource_group_name       = string
      location                  = optional(string)
      network_security_group_id = string
      storage_account_id        = string
      enabled                   = bool
      version                   = optional(string)
      tags                      = optional(map(string))
      retention_policy = object({
        enabled = bool
        days    = number
      })
      traffic_analytics = object({
        enabled               = bool
        workspace_id          = string
        workspace_region      = string
        workspace_resource_id = string
        interval_in_minutes   = optional(number)
      })
    })))
    group = optional(map(object({
      name                = string
      resource_group_name = string
      location            = string
      tags                = optional(map(string))
      security_rule = optional(list(object({
        description                                = optional(string)
        protocol                                   = string
        source_port_range                          = optional(string)
        source_port_ranges                         = optional(list(string))
        destination_port_range                     = optional(string)
        destination_port_ranges                    = optional(list(string))
        source_address_prefix                      = optional(string)
        source_address_prefixes                    = optional(list(string))
        source_application_security_group_ids      = optional(list(string))
        destination_address_prefix                 = optional(string)
        destination_address_prefixes               = optional(list(string))
        destination_application_security_group_ids = optional(list(string))
        access                                     = string
        priority                                   = number
        direction                                  = string
      })))
    })))
    rule = optional(map(object({
      name                                       = string
      resource_group_name                        = string
      network_security_group_name                = string
      location                                   = string
      description                                = optional(string)
      protocol                                   = string
      source_port_range                          = optional(string)
      source_port_ranges                         = optional(list(string))
      destination_port_range                     = optional(string)
      destination_port_ranges                    = optional(list(string))
      source_address_prefix                      = optional(string)
      source_address_prefixes                    = optional(list(string))
      source_application_security_group_ids      = optional(list(string))
      destination_address_prefix                 = optional(string)
      destination_address_prefixes               = optional(list(string))
      destination_application_security_group_ids = optional(list(string))
      access                                     = string
      priority                                   = number
      direction                                  = string
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
  # Azure Network Security Groups
  #
  azure_network_security_group = flatten([
    for nsg_id, nsg in coalesce(try(var.network_security.group, null), {}) : merge(
      nsg,
      {
        resource_index = join("_", [nsg_id])
      }
    )
  ])

  azure_network_security_rule = flatten([
    for rule_id, rule in coalesce(try(var.network_security.rule, null), {}) : merge(
      rule,
      {
        resource_index = join("_", [rule_id])
      }
    )
  ])

  #
  # Network Watcher Flow Logs
  #
  azure_network_watcher_flow_log = flatten([
    for flow_log_id, flow_log in coalesce(try(var.network_security.flow_log, null), {}) : merge(
      flow_log,
      {
        resource_index = join("_", [flow_log_id])
      }
    )
  ])
}
