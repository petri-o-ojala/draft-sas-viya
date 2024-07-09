#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_subnet    = optional(map(any))
    azure_key_vault = optional(map(any))
  })
  default = {}
}

locals {
  azure_subnet    = coalesce(var.reference.azure_subnet, {})
  azure_key_vault = coalesce(var.reference.azure_key_vault, {})
}
