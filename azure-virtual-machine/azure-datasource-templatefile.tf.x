#
# Template file datasources
#

locals {
  template_file = data.template_file.lz
}

data "template_file" "lz" {
  for_each = {
    for template in local.azure_template_file : template.resource_index => template
  }

  template = each.value.template_file != null ? "${file(each.value.template_file)}" : each.value.template
  vars     = each.value.vars
}
