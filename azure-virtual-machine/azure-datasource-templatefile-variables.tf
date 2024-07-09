#
# Template file datasources
#

variable "template_file" {
  type = map(object({
    template_file = optional(string)
    template      = optional(string)
    vars          = optional(map(string))
  }))
  default = {}
}

locals {
  #
  # Template file datasources
  #
  azure_template_file = flatten([
    for template_id, template in coalesce(try(var.template_file, null), {}) : merge(
      template,
      {
        resource_index = join("_", [template_id])
      }
    )
  ])
}
