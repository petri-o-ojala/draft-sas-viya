#
# Azure Windows Virtual Machine Extensions
#

resource "azurerm_virtual_machine_extension" "linux" {
  for_each = {
    for extension in local.azure_linux_virtual_machine_extension : extension.resource_index => extension
  }

  name                       = each.value.name
  virtual_machine_id         = each.value.virtual_machine_id
  publisher                  = each.value.publisher
  type                       = each.value.type
  type_handler_version       = each.value.type_handler_version
  auto_upgrade_minor_version = each.value.auto_upgrade_minor_version
  automatic_upgrade_enabled  = each.value.automatic_upgrade_enabled

  settings = each.value.settings == null ? null : jsonencode(merge(
    {
      for setting_key, setting_value in each.value.settings : setting_key => setting_value
      if !contains(local.keyvault_settings, setting_key)
    },
    {
      for setting_key, setting_value in each.value.settings : setting_key => lookup(local.template_file, setting_value, null) == null ? setting_value : "powershell -encodedCommand ${textencodebase64(local.template_file[setting_value].rendered, "UTF-16LE")}"
      if setting_key == "commandToExecute"
    },
    {
      for setting_key, setting_value in each.value.settings : setting_key => lookup(local.azure_key_vault, setting_value, null) == null ? setting_value : local.azure_key_vault[setting_value].vault_uri
      if setting_key == "KeyVaultURL"
    },
    {
      for setting_key, setting_value in each.value.settings : setting_key => lookup(local.azure_key_vault, setting_value, null) == null ? setting_value : local.azure_key_vault[setting_value].id
      if setting_key == "KeyVaultResourceId"
    }
  ))

  failure_suppression_enabled = each.value.failure_suppression_enabled
  protected_settings = each.value.protected_settings == null ? null : jsonencode(merge(
    {
      for setting_key, setting_value in each.value.protected_settings : setting_key => setting_value
      if !contains(local.keyvault_settings, setting_key)
    },
    {
      for setting_key, setting_value in each.value.protected_settings : setting_key => lookup(local.template_file, setting_value, null) == null ? setting_value : "powershell -encodedCommand ${textencodebase64(local.template_file[setting_value].rendered, "UTF-16LE")}"
      if setting_key == "commandToExecute"
    },
    {
      for setting_key, setting_value in each.value.protected_settings : setting_key => lookup(local.azure_key_vault, setting_value, null) == null ? setting_value : local.azure_key_vault[setting_value].vault_uri
      if setting_key == "KeyVaultURL"
    },
    {
      for setting_key, setting_value in each.value.protected_settings : setting_key => lookup(local.azure_key_vault, setting_value, null) == null ? setting_value : local.azure_key_vault[setting_value].id
      if setting_key == "KeyVaultResourceId"
    }
  ))

  dynamic "protected_settings_from_key_vault" {
    for_each = try(each.value.protected_settings_from_key_vault, null) == null ? [] : [1]

    content {
      secret_url      = each.value.protected_settings_from_key_vault.secret_url
      source_vault_id = each.value.protected_settings_from_key_vault.source_vault_id
    }
  }

  provision_after_extensions = each.value.provision_after_extensions
  tags                       = each.value.tags
}
