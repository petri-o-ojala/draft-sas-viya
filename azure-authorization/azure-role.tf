#
# Azure Roles
#

locals {
  azurerm_role_definition            = azurerm_role_definition.lz
  azurerm_role_assignment            = azurerm_role_assignment.lz
  predefined_azurerm_role_definition = data.azurerm_role_definition.lz
  azure_principal_id = merge(
    local.entra_id_alias,
    {
      for identity_id, identity in local.azurerm_user_assigned_identity : identity_id => identity.principal_id
    }
  )
}

data "azurerm_role_definition" "lz" {
  for_each = toset(local.iam_predefined_roles)

  name = each.key
}

resource "azurerm_role_definition" "lz" {
  for_each = {
    for role in local.azure_role_definition : role.resource_index => role
  }

  name  = each.value.name
  scope = each.value.scope

  description        = each.value.description
  assignable_scopes  = each.value.assignable_scopes
  role_definition_id = each.value.role_definition_id

  dynamic "permissions" {
    for_each = try(each.value.permissions, null) == null ? [] : [1]

    content {
      actions          = each.value.permissions.actions
      data_actions     = each.value.permissions.data_actions
      not_actions      = each.value.permissions.not_actions
      not_data_actions = each.value.permissions.not_data_actions
    }
  }

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_role_assignment" "lz" {
  for_each = {
    for assignment in local.azure_role_assignment : assignment.resource_index => assignment
  }

  name         = each.value.name
  principal_id = lookup(local.azure_principal_id, each.value.principal_id, null) == null ? each.value.principal_id : local.azure_principal_id[each.value.principal_id]
  scope        = each.value.scope

  role_definition_id                     = each.value.role_definition_id == null ? null : lookup(local.azurerm_role_definition, each.value.role_definition_id, null) == null ? each.value.role_definition_id : local.azurerm_role_definition[each.value.role_definition_id].role_definition_resource_id
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

resource "azurerm_marketplace_role_assignment" "lz" {
  for_each = {
    for assignment in local.azurm_marketplace_role_assignment : assignment.resource_index => assignment
  }

  name                                   = each.value.name
  principal_id                           = each.value.principal_id
  role_definition_id                     = each.value.role_definition_id
  role_definition_name                   = each.value.role_definition_name
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
