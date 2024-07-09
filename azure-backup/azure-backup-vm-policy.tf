#
# Azure Backup VM Policies
#

locals {
  azurerm_backup_policy_vm = merge(
    azurerm_backup_policy_vm.lz,
    data.azurerm_backup_policy_vm.lz
  )
}

locals {
  #
  # Find all backup policies that are not created by this module call
  #
  vm_backup_policies = {
    for vm in local.azure_backup_vm_protection : vm.vm_backup_policy => vm
    if lookup(coalesce(var.backup.vm_policy, {}), vm.vm_backup_policy, null) == null
  }
}

data "azurerm_backup_policy_vm" "lz" {
  for_each = local.vm_backup_policies

  name                = each.key
  recovery_vault_name = each.value.recovery_vault_name
  resource_group_name = each.value.recovery_vault_resource_group_name
}

resource "azurerm_backup_policy_vm" "lz" {
  for_each = {
    for policy in local.azure_backup_policy_vm : policy.resource_index => policy
  }

  name                           = each.value.name
  resource_group_name            = each.value.resource_group_name
  recovery_vault_name            = each.value.recovery_vault_name
  policy_type                    = each.value.policy_type
  timezone                       = each.value.timezone
  instant_restore_retention_days = each.value.instant_restore_retention_days

  dynamic "backup" {
    for_each = try(each.value.backup, null) == null ? [] : [1]

    content {
      frequency     = each.value.backup.frequency
      time          = each.value.backup.time
      hour_interval = each.value.backup.hour_interval
      hour_duration = each.value.backup.hour_duration
      weekdays      = each.value.backup.weekdays
    }
  }

  dynamic "retention_daily" {
    for_each = try(each.value.retention_daily, null) == null ? [] : [1]

    content {
      count = each.value.retention_daily.count
    }
  }

  dynamic "retention_weekly" {
    for_each = try(each.value.retention_weekly, null) == null ? [] : [1]

    content {
      count    = each.value.retention_weekly.count
      weekdays = each.value.retention_weekly.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = try(each.value.retention_monthly, null) == null ? [] : [1]

    content {
      count             = each.value.retention_monthly.count
      weekdays          = each.value.retention_monthly.weekdays
      weeks             = each.value.retention_monthly.weeks
      days              = each.value.retention_monthly.days
      include_last_days = each.value.retention_monthly.include_last_days
    }
  }

  dynamic "retention_yearly" {
    for_each = try(each.value.retention_yearly, null) == null ? [] : [1]

    content {
      count             = each.value.retention_yearly.count
      months            = each.value.retention_yearly.months
      weekdays          = each.value.retention_yearly.weekdays
      weeks             = each.value.retention_yearly.weeks
      days              = each.value.retention_yearly.days
      include_last_days = each.value.retention_yearly.include_last_days
    }
  }

  dynamic "instant_restore_resource_group" {
    for_each = try(each.value.instant_restore_resource_group, null) == null ? [] : [1]

    content {
      prefix = each.value.instant_restore_resource_group.prefix
      suffix = each.value.instant_restore_resource_group.suffix
    }
  }

  depends_on = [
    azurerm_recovery_services_vault.lz
  ]
}
