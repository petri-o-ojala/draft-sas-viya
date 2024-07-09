#
# Input references to other resources
#

variable "reference" {
  description = "Azure Resource references"
  type = object({
    azure_windows_virtual_machine = optional(map(any))
  })
  default = {}
}

locals {
  azure_windows_virtual_machine = coalesce(var.reference.azure_windows_virtual_machine, {})
}
