#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_network_security_group  = optional(map(any))
    azure_resource_group          = optional(map(any))
    azure_log_analytics_workspace = optional(map(any))
    azure_storage_account         = optional(map(any))
    azure_virtual_network         = optional(map(any))
    azure_subnet                  = optional(map(any))
    azure_private_dns_zone        = optional(map(any))
    azure_role_definition         = optional(map(any))
    azure_resource_principal_id   = optional(map(any))
    azure_resource_id             = optional(map(any))
  })
  default = {}
}

locals {
  azure_network_security_group  = coalesce(var.reference.azure_network_security_group, {})
  azure_resource_group          = coalesce(var.reference.azure_resource_group, {})
  azure_log_analytics_workspace = coalesce(var.reference.azure_log_analytics_workspace, {})
  azure_storage_account         = coalesce(var.reference.azure_storage_account, {})
  azure_subnet                  = coalesce(var.reference.azure_subnet, {})
  azure_private_dns_zone        = coalesce(var.reference.azure_private_dns_zone, {})
  azure_role_definition         = coalesce(var.reference.azure_role_definition, {})
  azure_resource_principal_id   = coalesce(var.reference.azure_resource_principal_id, {})
  azure_resource_id             = coalesce(var.reference.azure_resource_id, {})
}
