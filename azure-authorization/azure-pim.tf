#
# Azure PIM
#

locals {
}

resource "azurerm_pim_active_role_assignment" "lz" {
  for_each = {
    for assignment in local.azure_pim_active_role_assignment : assignment.resource_index => assignment
  }

  principal_id       = each.value.principal_id
  role_definition_id = each.value.role_definition_id
  scope              = each.value.scope
  justification      = each.value.justification

  dynamic "schedule" {
    for_each = try(each.value.schedule, null) == null ? [] : [1]

    content {
      start_date_time = each.value.schedule.start_date_time

      dynamic "expiration" {
        for_each = try(each.value.schedule.expiration, null) == null ? [] : [1]

        content {
          duration_days  = each.value.schedule.expiration.duration_days
          duration_hours = each.value.schedule.expiration.duration_hours
          end_date_time  = each.value.schedule.expiration.end_date_time
        }
      }
    }
  }

  dynamic "ticket" {
    for_each = try(each.value.ticket, null) == null ? [] : [1]

    content {
      number = each.value.ticket.number
      system = each.value.ticket.system
    }
  }

  timeouts {
    # Default for all resources
    create = "15m"
    delete = "15m"
  }
}

resource "azurerm_pim_eligible_role_assignment" "lz" {
  for_each = {
    for assignment in local.azure_pim_eligible_role_assignment : assignment.resource_index => assignment
  }

  principal_id       = each.value.principal_id
  role_definition_id = each.value.role_definition_id
  scope              = each.value.scope
  justification      = each.value.justification

  dynamic "schedule" {
    for_each = try(each.value.schedule, null) == null ? [] : [1]

    content {
      start_date_time = each.value.schedule.start_date_time

      dynamic "expiration" {
        for_each = try(each.value.schedule.expiration, null) == null ? [] : [1]

        content {
          duration_days  = each.value.schedule.expiration.duration_days
          duration_hours = each.value.schedule.expiration.duration_hours
          end_date_time  = each.value.schedule.expiration.end_date_time
        }
      }
    }
  }

  dynamic "ticket" {
    for_each = try(each.value.ticket, null) == null ? [] : [1]

    content {
      number = each.value.ticket.number
      system = each.value.ticket.system
    }
  }

  timeouts {
    # Default for all resources
    create = "15m"
    delete = "15m"
  }
}
