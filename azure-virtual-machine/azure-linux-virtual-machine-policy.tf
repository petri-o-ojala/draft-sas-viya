#
# Guest Configuration Policy assignments
#

resource "azurerm_policy_virtual_machine_configuration_assignment" "linux" {
  for_each = {
    for extension in local.azure_linux_virtual_machine_policy : extension.resource_index => extension
  }

  name               = each.value.name
  location           = each.value.location
  virtual_machine_id = each.value.virtual_machine_id

  dynamic "configuration" {
    for_each = try(each.value.configuration, null) == null ? [] : [1]

    content {
      assignment_type = each.value.configuration.assignment_type
      content_hash    = each.value.configuration.content_hash
      content_uri     = each.value.configuration.content_uri
      version         = each.value.configuration.version

      dynamic "parameter" {
        for_each = coalesce(each.value.configuration.parameter, [])

        content {
          name  = parameter.value.name
          value = parameter.value.value
        }
      }
    }
  }
}
