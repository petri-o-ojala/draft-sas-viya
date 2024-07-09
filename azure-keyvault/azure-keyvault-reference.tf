#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_subnet                  = optional(map(any))
    azure_log_analytics_workspace = optional(map(any))
    azure_storage_account         = optional(map(any))
    azure_private_dns_zone        = optional(map(any))
    azure_resource_group          = optional(map(any))
    azure_role_definition         = optional(map(any))
    azure_resource_principal_id   = optional(map(any))
    azure_key_vault               = optional(map(any))
  })
  default = {}
}

locals {
  azure_subnet                  = coalesce(var.reference.azure_subnet, {})
  azure_log_analytics_workspace = coalesce(var.reference.azure_log_analytics_workspace, {})
  azure_storage_account         = coalesce(var.reference.azure_storage_account, {})
  azure_private_dns_zone        = coalesce(var.reference.azure_private_dns_zone, {})
  azure_resource_group          = coalesce(var.reference.azure_resource_group, {})
  azure_role_definition         = coalesce(var.reference.azure_role_definition, {})
  azure_resource_principal_id   = coalesce(var.reference.azure_resource_principal_id, {})
  azure_key_vault_reference     = coalesce(var.reference.azure_key_vault, {})
}
