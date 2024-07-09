#
# Azure Recovery Services Vaults
#

locals {
  azurerm_recovery_services_vault = azurerm_recovery_services_vault.lz
}

resource "azurerm_recovery_services_vault" "lz" {
  for_each = {
    for vault in local.azure_recovery_services_vault : vault.resource_index => vault
  }

  name                               = each.value.name
  resource_group_name                = each.value.resource_group_name
  location                           = each.value.location
  tags                               = each.value.tags
  sku                                = each.value.sku
  public_network_access_enabled      = each.value.public_network_access_enabled
  immutability                       = each.value.immutability
  storage_mode_type                  = each.value.storage_mode_type
  cross_region_restore_enabled       = each.value.cross_region_restore_enabled
  classic_vmware_replication_enabled = each.value.classic_vmware_replication_enabled

  dynamic "identity" {
    # (Optional) An identity block 
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "encryption" {
    for_each = try(each.value.encryption, null) == null ? [] : [1]

    content {
      key_id                            = each.value.encryption.key_id
      infrastructure_encryption_enabled = each.value.encryption.infrastructure_encryption_enabled
      user_assigned_identity_id         = each.value.encryption.user_assigned_identity_id
      use_system_assigned_identity      = each.value.encryption.use_system_assigned_identity
    }
  }

  dynamic "monitoring" {
    for_each = try(each.value.monitoring, null) == null ? [] : [1]

    content {
      alerts_for_all_job_failures_enabled            = each.value.monitoring.alerts_for_all_job_failures_enabled
      alerts_for_critical_operation_failures_enabled = each.value.monitoring.alerts_for_critical_operation_failures_enabled
    }
  }
}
