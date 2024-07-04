#
# Common variables
#

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
}

variable "entra_id" {
  description = "Entra ID configuration"
  type = object({
    alias = optional(map(string), {})
  })
  default = {
    alias = {}
  }
}

locals {
  #
  # Entra ID configuration
  #
  entra_id       = var.entra_id
  entra_id_alias = try(local.entra_id.alias, {})
}
