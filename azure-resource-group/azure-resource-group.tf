#
# Azure Resource Groups
#

locals {
  azurerm_resource_group = azurerm_resource_group.lz
}

resource "azurerm_resource_group" "lz" {
  for_each = {
    for group in local.azure_resource_group : group.resource_index => group
  }

  name       = each.value.name
  location   = each.value.location
  managed_by = each.value.managed_by
  tags       = each.value.tags
}

resource "azurerm_management_lock" "resource_group" {
  for_each = {
    for group in local.azure_resource_group : group.resource_index => group
    if group.management_lock != null
  }

  name       = coalesce(each.value.management_lock.name, each.value.name)
  scope      = local.azurerm_resource_group[each.key].id
  lock_level = each.value.management_lock.lock_level
  notes      = each.value.management_lock.notes
}
