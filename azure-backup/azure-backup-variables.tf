#
# Azure Recovery Services Vaults
#

variable "backup" {
  type = object({
    vm_backup = optional(list(object({
      vm_name                            = string
      vm_configuration_name              = optional(string)
      resource_group_name                = string
      vm_backup_policy                   = string
      recovery_vault_name                = optional(string)
      recovery_vault_resource_group_name = optional(string)
    })))
    vm_policy = optional(map(object({
      name                           = string
      resource_group_name            = string
      recovery_vault_name            = string
      policy_type                    = optional(string)
      timezone                       = string
      instant_restore_retention_days = optional(number)
      backup = object({
        frequency     = string
        time          = string
        hour_interval = optional(number)
        hour_duration = optional(number)
        weekdays      = optional(list(string))
      })
      retention_daily = optional(object({
        count = number
      }))
      retention_weekly = optional(object({
        count    = number
        weekdays = list(string)
      }))
      retention_monthly = optional(object({
        count             = number
        weekdays          = optional(list(string))
        weeks             = optional(list(string))
        days              = optional(list(string))
        include_last_days = optional(bool)
      }))
      retention_yearly = optional(object({
        count             = number
        months            = list(string)
        weekdays          = optional(list(string))
        weeks             = optional(list(string))
        days              = optional(list(string))
        include_last_days = optional(bool)
      }))
      instant_restore_resource_group = optional(object({
        prefix = optional(string)
        suffix = optional(string)
      }))
    })))
    recovery_services_vault = optional(map(object({
      name                = string
      resource_group_name = string
      location            = string
      tags                = optional(map(string))
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      public_network_access_enabled = optional(bool)
      sku                           = string
      immutability                  = optional(string)
      storage_mode_type             = optional(string)
      cross_region_restore_enabled  = optional(string)
      soft_delete_enabled           = optional(string)
      encryption = optional(object({
        key_id                            = string
        infrastructure_encryption_enabled = bool
        user_assigned_identity_id         = optional(string)
        use_system_assigned_identity      = optional(bool)
      }))
      classic_vmware_replication_enabled = optional(bool)
      monitoring = optional(object({
        alerts_for_all_job_failures_enabled            = optional(bool)
        alerts_for_critical_operation_failures_enabled = optional(bool)
      }))
    })))
  })
  default = {}
}

variable "common" {
  #
  # Common data for all resources
  #
  description = "Common Azure resource parameters"
  type = object({
    tags            = optional(map(string))
    custom_metadata = optional(map(string))
  })
  default = {}
}

locals {
  # Use local variable to allow easier long-term development
  common = var.common

  #
  # Azure Recovery Services Vaults
  #
  azure_recovery_services_vault = flatten([
    for vault_id, vault in coalesce(try(var.backup.recovery_services_vault, null), {}) : merge(
      vault,
      {
        resource_index = join("_", [vault_id])
      }
    )
  ])

  #
  # Azure Backup for VMs policies
  #
  azure_backup_policy_vm = flatten([
    for policy_id, policy in coalesce(try(var.backup.vm_policy, null), {}) : merge(
      policy,
      {
        resource_index = join("_", [policy_id])
      }
    )
  ])

  #
  # Azure Backup for VMs protections
  #
  azure_backup_vm_protection = flatten([
    for vm_backup in coalesce(try(var.backup.vm_backup, null), []) : merge(
      vm_backup,
      {
        resource_index = join("_", [vm_backup.resource_group_name, vm_backup.vm_name])
      }
    )
  ])
}
