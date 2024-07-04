#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_log_analytics_workspace = optional(map(any))
    azure_storage_account         = optional(map(any))
    azure_resource_group          = optional(map(any))
  })
  default = {}
}

locals {
  azure_log_analytics_workspace = coalesce(var.reference.azure_log_analytics_workspace, {})
  azure_storage_account         = coalesce(var.reference.azure_storage_account, {})
  azure_resource_group          = coalesce(var.reference.azure_resource_group, {})
}
