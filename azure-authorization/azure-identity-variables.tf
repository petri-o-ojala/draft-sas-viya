#
# Azure Identities
#

variable "identity" {
  description = "Azure Identities"
  type = object({
    user_assigned = optional(map(object({
      name                = string
      location            = string
      resource_group_name = string
      tags                = optional(map(string))
      federated_credential = optional(list(object({
        name                = string
        resource_group_name = optional(string)
        audience            = list(string)
        issuer              = string
        parent_id           = optional(string)
        subject             = string
      })))
      iam = optional(list(object({
        name                                   = optional(string)
        role_definition_name                   = optional(string)
        role_definition_id                     = optional(string)
        principal_type                         = optional(string)
        scope                                  = optional(string)
        condition                              = optional(string)
        condition_version                      = optional(string)
        delegated_managed_identity_resource_id = optional(string)
        description                            = optional(string)
        skip_service_principal_aad_check       = optional(bool)
      })))
    })))
  })
  default = {}
}

locals {
  #
  # Azure User Assigned Identity
  #
  azure_user_assigned_identity = flatten([
    for identity_id, identity in coalesce(try(var.identity.user_assigned, null), {}) : merge(
      identity,
      {
        resource_index = join("_", [identity_id])
      }
    )
  ])

  azure_user_assigned_identity_iam = flatten([
    for identity_id, identity in coalesce(try(var.identity.user_assigned, null), {}) : [
      for iam in coalesce(try(identity.iam, null), []) : merge(
        iam,
        {
          scope          = iam.scope # == null ? "/subscriptions/${azurerm_subscription.lz[subscription_id].subscription_id}" : iam.scope
          principal_id   = local.azurerm_user_assigned_identity[identity_id].principal_id
          resource_index = join("_", [identity_id, coalesce(iam.role_definition_name, iam.role_definition_id)])
        }
      )
    ]
  ])

  #
  # Federated Identity Credentials
  #
  azure_federated_identity_credential = flatten([
    for identity_id, identity in coalesce(try(var.identity.user_assigned, null), {}) : [
      for federation in coalesce(identity.federated_credential, []) : merge(
        federation,
        {
          parent_id           = local.azurerm_user_assigned_identity[identity_id].id
          resource_group_name = coalesce(federation.resource_group_name, identity.resource_group_name)
          resource_index      = join("_", [identity_id, federation.name])
        }
      )
    ]
  ])
}
