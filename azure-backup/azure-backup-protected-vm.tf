#
# Azure Backup for VMs protection
#

#
# Obtain details for all backup protected VMs
#
/*
data "azurerm_virtual_machine" "lz" {
  for_each = {
    for vm in local.azure_backup_vm_protection : vm.resource_index => vm
  }

  name                = each.value.vm_name
  resource_group_name = each.value.resource_group_name
}
*/

#
# Assign Backup protection for each VM
#
resource "azurerm_backup_protected_vm" "lz" {
  for_each = {
    for vm in local.azure_backup_vm_protection : vm.resource_index => vm
  }

  resource_group_name = local.azurerm_backup_policy_vm[each.value.vm_backup_policy].resource_group_name
  recovery_vault_name = local.azurerm_backup_policy_vm[each.value.vm_backup_policy].recovery_vault_name
  source_vm_id        = local.azure_windows_virtual_machine[coalesce(each.value.vm_configuration_name, each.value.vm_name)].id # data.azurerm_virtual_machine.lz[each.key].id
  backup_policy_id    = local.azurerm_backup_policy_vm[each.value.vm_backup_policy].id
}
