#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_resource_group = optional(map(any))
  })
  default = {}
}

locals {
  azure_resource_group = coalesce(var.reference.azure_resource_group, {})
}
