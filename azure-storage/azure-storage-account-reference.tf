#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_log_analytics_workspace = optional(map(any))
    azure_private_dns_zone        = optional(map(any))
    azure_subnet                  = optional(map(any))
    azure_role_definition         = optional(map(any))
    azure_resource_principal_id   = optional(map(any))
    azure_resource_id             = optional(map(any))
  })
  default = {}
}

locals {
  azure_log_analytics_workspace = coalesce(var.reference.azure_log_analytics_workspace, {})
  azure_private_dns_zone        = coalesce(var.reference.azure_private_dns_zone, {})
  azure_subnet                  = coalesce(var.reference.azure_subnet, {})
  azure_role_definition         = coalesce(var.reference.azure_role_definition, {})
  azure_resource_principal_id   = coalesce(var.reference.azure_resource_principal_id, {})
  azure_resource_id             = coalesce(var.reference.azure_resource_id, {})
}
