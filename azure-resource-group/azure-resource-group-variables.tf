#
# Azure Resource Groups
#

variable "resource_group" {
  type = map(object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
    management_lock = optional(object({
      name       = optional(string)
      lock_level = optional(string, "CanNotDelete")
      notes      = optional(string)
    }))
  }))
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
  # Azure Resource groups
  #
  azure_resource_group = flatten([
    for group_id, group in coalesce(try(var.resource_group, null), {}) : merge(
      group,
      {
        resource_index = join("_", [group_id])
      }
    )
  ])
}
