#
# Azure PIM
#

variable "pim" {
  description = "Azure PIM"
  type = object({
    active_role_assignment = optional(map(object({
      principal_id       = string
      role_definition_id = string
      scope              = string
      justification      = optional(string)
      schedule = optional(object({
        start_date_time = optional(string)
        expiration = optional(object({
          duration_days  = optional(string)
          duration_hours = optional(string)
          end_date_time  = optional(string)
        }))
      }))
      ticket = optional(object({
        number = optional(string)
        system = optional(string)
      }))
    })))
    eligible_role_assignment = optional(map(object({
      principal_id       = string
      role_definition_id = string
      scope              = string
      justification      = optional(string)
      schedule = optional(object({
        start_date_time = optional(string)
        expiration = optional(object({
          duration_days  = optional(string)
          duration_hours = optional(string)
          end_date_time  = optional(string)
        }))
      }))
      ticket = optional(object({
        number = optional(string)
        system = optional(string)
      }))
    })))
  })
  default = {}
}

locals {
  #
  # Azure PIM Active Role Assignments
  #
  azure_pim_active_role_assignment = flatten([
    for assignment_id, assignment in coalesce(try(var.pim.active_role_assignment, null), {}) : merge(
      assignment,
      {
        resource_index = join("_", [assignment_id])
      }
    )
  ])

  azure_pim_eligible_role_assignment = flatten([
    for assignment_id, assignment in coalesce(try(var.pim.eligible_role_assignment, null), {}) : merge(
      assignment,
      {
        resource_index = join("_", [assignment_id])
      }
    )
  ])
}
