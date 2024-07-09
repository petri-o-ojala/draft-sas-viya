#
# Azure Storage Account Containers
#

locals {
  azurerm_storage_container = azurerm_storage_container.lz
}

resource "azurerm_storage_container" "lz" {
  for_each = {
    for container in local.azure_storage_container : container.resource_index => container
  }

  name                  = each.value.name
  storage_account_name  = each.value.storage_account_name
  container_access_type = each.value.container_access_type

  # default_encryption_scope          = each.value.default_encryption_scope
  # encryption_scope_override_enabled = each.value.encryption_scope_override_enabled
  metadata = each.value.metadata

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_role_assignment" "storage_container" {
  for_each = {
    for assignment in local.azure_storage_container_iam : assignment.resource_index => assignment
  }

  name         = each.value.name
  principal_id = lookup(local.azure_principal_id, each.value.principal_id, null) == null ? each.value.principal_id : local.azure_principal_id[each.value.principal_id]
  scope        = each.value.scope

  role_definition_id                     = each.value.role_definition_id == null ? null : lookup(local.azure_role_definition, each.value.role_definition_id, null) == null ? each.value.role_definition_id : local.azure_role_definition[each.value.role_definition_id].id
  role_definition_name                   = each.value.role_definition_name
  principal_type                         = each.value.principal_type
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  description                            = each.value.description
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check

  timeouts {
    # Default for all resources
    create = "15m"
    delete = "15m"
  }
}
