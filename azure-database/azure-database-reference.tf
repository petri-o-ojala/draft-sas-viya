#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_subnet                  = optional(map(any))
    azure_windows_virtual_machine = optional(map(any))
  })
  default = {}
}

locals {
  azure_subnet                  = coalesce(var.reference.azure_subnet, {})
  azure_windows_virtual_machine = coalesce(var.reference.azure_windows_virtual_machine, {})
}
