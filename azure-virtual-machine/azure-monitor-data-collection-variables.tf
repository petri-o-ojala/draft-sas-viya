#
# Azure Virtual Machine monitoring
#

variable "monitoring" {
  type = object({
    data_collection_rule = optional(map(object({
      data_collection_rule                     = string
      data_collection_rule_resource_group_name = string
      name                                     = string
      description                              = optional(string)
      virtual_machine                          = list(string)
    })))
  })
  default = {}
}

locals {
  #
  # Azure Monitor Data Collection Rules
  #
  azure_data_collection_rule = flatten([
    for rule_id, rule in coalesce(try(var.monitoring.data_collection_rule, null), {}) : merge(
      rule,
      {
        resource_index = join("_", [rule_id, rule.data_collection_rule])
      }
    )
  ])

  #
  # Azure Monitor Data Collection Rule Associations
  #
  azure_data_collection_rule_association = flatten([
    for rule_id, rule in coalesce(try(var.monitoring.data_collection_rule, null), {}) : [
      for vm in rule.virtual_machine : merge(
        rule,
        {
          target_resource_id      = lookup(local.azurerm_windows_virtual_machine, vm, null) == null ? vm : local.azurerm_windows_virtual_machine[vm].id
          data_collection_rule_id = data.azurerm_monitor_data_collection_rule.lz[join("_", [rule_id, rule.data_collection_rule])].id
          resource_index          = join("_", [rule_id, vm])
        }
      )
    ]
  ])
}
