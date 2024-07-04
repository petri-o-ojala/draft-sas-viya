#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_resource_group        = optional(map(any))
    azure_virtual_network       = optional(map(any))
    azure_role_definition       = optional(map(any))
    azure_resource_principal_id = optional(map(any))
  })
  default = {}
}

locals {
  azure_resource_group        = coalesce(var.reference.azure_resource_group, {})
  azure_virtual_network       = coalesce(var.reference.azure_virtual_network, {})
  azure_role_definition       = coalesce(var.reference.azure_role_definition, {})
  azure_resource_principal_id = coalesce(var.reference.azure_resource_principal_id, {})
}
