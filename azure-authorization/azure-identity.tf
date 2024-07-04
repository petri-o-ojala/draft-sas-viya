#
# Azure Identities
#

locals {
  azurerm_user_assigned_identity        = azurerm_user_assigned_identity.lz
  azurerm_federated_identity_credential = azurerm_federated_identity_credential.lz
}

resource "azurerm_user_assigned_identity" "lz" {
  for_each = {
    for identity in local.azure_user_assigned_identity : identity.resource_index => identity
  }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_federated_identity_credential" "lz" {
  for_each = {
    for credential in local.azure_federated_identity_credential : credential.resource_index => credential
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  audience            = each.value.audience
  issuer              = each.value.issuer
  parent_id           = lookup(local.azurerm_user_assigned_identity, each.value.parent_id, null) == null ? each.value.parent_id : local.azurerm_user_assigned_identity[each.value.parent_id].id
  subject             = each.value.subject
}

resource "azurerm_role_assignment" "user_assigned_identity" {
  for_each = {
    for assignment in local.azure_user_assigned_identity_iam : assignment.resource_index => assignment
  }

  name         = each.value.name
  principal_id = each.value.principal_id
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
