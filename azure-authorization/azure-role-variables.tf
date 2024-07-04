#
# Azure Roles
#

variable "role" {
  description = "Azure Roles"
  type = object({
    definition = optional(map(object({
      name                = string
      scope               = string
      description         = optional(string)
      assignable_scopes   = optional(list(string))
      role_definition_id  = optional(string)
      predefined_role     = optional(list(string))
      exclude_permissions = optional(list(string))
      permissions = optional(object({
        actions          = optional(list(string))
        data_actions     = optional(list(string))
        not_actions      = optional(list(string))
        not_data_actions = optional(list(string))
      }))
    })))
    assignment = optional(map(object({
      name                                   = optional(string)
      principal_id                           = string
      scope                                  = string
      role_definition_id                     = optional(string)
      role_definition_name                   = optional(string)
      role_definition_names                  = optional(list(string))
      principal_type                         = optional(string)
      condition                              = optional(string)
      condition_version                      = optional(string)
      delegated_managed_identity_resource_id = optional(string)
      description                            = optional(string)
      skip_service_principal_aad_check       = optional(bool)
    })))
    marketplace_assignment = optional(map(object({
    })))
  })
  default = {}
}

locals {
  #
  # Pre-defined IAM roles that are used by the custom roles
  #
  iam_predefined_roles = distinct(flatten(concat(
    [
      for role_id, role in coalesce(try(var.role.definition, null), {}) : coalesce(role.predefined_role, [])
    ]
  )))

  #
  # Azure Roles
  #
  azure_role_definition = concat(
    flatten([
      for role_id, role in coalesce(try(var.role.definition, null), {}) : merge(
        role,
        {
          resource_index = join("_", [role_id])
        }
      )
      if role.predefined_role == null
    ]),
    flatten([
      for role_id, role in coalesce(try(var.role.definition, null), {}) : merge(
        role,
        {
          permissions = {
            actions = distinct(concat(
              coalesce(role.permissions.actions, []),
              flatten([
                for predefined_role in role.predefined_role : flatten([
                  for permission in local.predefined_azurerm_role_definition[predefined_role].permissions : [
                    for permission_value in permission.actions : permission_value
                    if !contains(coalesce(role.exclude_permissions, []), permission_value)
                  ]
                ])
              ])
            ))
            not_actions = distinct(concat(
              coalesce(role.permissions.not_actions, []),
              flatten([
                for predefined_role in role.predefined_role : flatten([
                  for permission in local.predefined_azurerm_role_definition[predefined_role].permissions : [
                    for permission_value in permission.not_actions : permission_value
                    if !contains(coalesce(role.exclude_permissions, []), permission_value)
                  ]
                ])
              ])
            ))
            data_actions = distinct(concat(
              coalesce(role.permissions.data_actions, []),
              flatten([
                for predefined_role in role.predefined_role : flatten([
                  for permission in local.predefined_azurerm_role_definition[predefined_role].permissions : [
                    for permission_value in permission.data_actions : permission_value
                    if !contains(coalesce(role.exclude_permissions, []), permission_value)
                  ]
                ])
              ])
            ))
            not_data_actions = distinct(concat(
              coalesce(role.permissions.not_data_actions, []),
              flatten([
                for predefined_role in role.predefined_role : flatten([
                  for permission in local.predefined_azurerm_role_definition[predefined_role].permissions : [
                    for permission_value in permission.not_data_actions : permission_value
                    if !contains(coalesce(role.exclude_permissions, []), permission_value)
                  ]
                ])
              ])
            ))
          }
          resource_index = join("_", [role_id])
        }
      )
      if role.predefined_role != null

    ])
  )

  azure_role_assignment = flatten(concat(
    [
      # Role assignments with ID
      for assignment_id, assignment in coalesce(try(var.role.assignment, null), {}) : merge(
        assignment,
        {
          resource_index = join("_", [assignment_id])
        }
      )
      if assignment.role_definition_id != null
    ],
    [
      # Role assignments with single name
      for assignment_id, assignment in coalesce(try(var.role.assignment, null), {}) : merge(
        assignment,
        {
          resource_index = join("_", [assignment_id, assignment.role_definition_name])
        }
      )
      if assignment.role_definition_name != null
    ],
    [
      # Role assignments with multiple names
      for assignment_id, assignment in coalesce(try(var.role.assignment, null), {}) : [
        for role_definition_name in assignment.role_definition_names : merge(
          assignment,
          {
            role_definition_name = role_definition_name
            resource_index       = join("_", [assignment_id, role_definition_name])
          }
        )
      ]
      if assignment.role_definition_names != null
    ]
  ))

  azurm_marketplace_role_assignment = flatten([
    for assignment_id, assignment in coalesce(try(var.role.marketplace_assignment, null), {}) : merge(
      assignment,
      {
        resource_index = join("_", [assignment_id])
      }
    )
  ])
}
