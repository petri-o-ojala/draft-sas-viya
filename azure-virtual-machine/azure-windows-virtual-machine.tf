#
# Azure Windows Virtual Machines
#

locals {
  azurerm_windows_virtual_machine = azurerm_windows_virtual_machine.lz
}

resource "azurerm_windows_virtual_machine" "lz" {
  for_each = {
    for vm in local.azure_windows_virtual_machine : vm.resource_index => vm
  }

  lifecycle {
    ignore_changes = [
      admin_username,
      admin_password
    ]
  }

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  admin_username      = each.value.admin_username == null ? null : lookup(local.azurerm_key_vault_secret, each.value.admin_username, null) == null ? each.value.admin_username : data.azurerm_key_vault_secret.lz[each.value.admin_username].value # local.azurerm_key_vault_secret[each.value.admin_username].value
  admin_password      = each.value.admin_password == null ? null : lookup(local.azurerm_key_vault_secret, each.value.admin_password, null) == null ? each.value.admin_password : data.azurerm_key_vault_secret.lz[each.value.admin_password].value # local.azurerm_key_vault_secret[each.value.admin_password].value
  size                = each.value.size

  network_interface_ids = [
    for nic_id in each.value.network_interface_ids : lookup(local.azurerm_network_interface, nic_id, null) == null ? nic_id : local.azurerm_network_interface[nic_id].id
  ]

  os_disk {
    caching                          = each.value.os_disk.caching
    storage_account_type             = each.value.os_disk.storage_account_type
    disk_encryption_set_id           = each.value.os_disk.disk_encryption_set_id
    disk_size_gb                     = each.value.os_disk.disk_size_gb
    name                             = each.value.os_disk.name
    secure_vm_disk_encryption_set_id = each.value.os_disk.secure_vm_disk_encryption_set_id
    security_encryption_type         = each.value.os_disk.security_encryption_type
    write_accelerator_enabled        = each.value.os_disk.write_accelerator_enabled
  }

  source_image_id = each.value.source_image_id

  dynamic "source_image_reference" {
    for_each = try(each.value.source_image_reference, null) == null ? [] : [1]

    content {
      publisher = each.value.source_image_reference.publisher
      offer     = each.value.source_image_reference.offer
      sku       = each.value.source_image_reference.sku
      version   = each.value.source_image_reference.version
    }
  }

  dynamic "additional_capabilities" {
    for_each = try(each.value.additional_capabilities, null) == null ? [] : [1]

    content {
      ultra_ssd_enabled = each.value.additional_capabilities.ultra_ssd_enabled
    }
  }

  allow_extension_operations = each.value.allow_extension_operations
  availability_set_id        = each.value.availability_set_id

  dynamic "boot_diagnostics" {
    for_each = try(each.value.boot_diagnostics, null) == null ? [] : [1]

    content {
      storage_account_uri = each.value.boot_diagnostics.storage_account_uri
    }
  }
  bypass_platform_safety_checks_on_user_schedule_enabled = each.value.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = each.value.capacity_reservation_group_id
  computer_name                                          = each.value.computer_name
  custom_data                                            = each.value.custom_data
  dedicated_host_id                                      = each.value.dedicated_host_id
  dedicated_host_group_id                                = each.value.dedicated_host_group_id
  enable_automatic_updates                               = each.value.enable_automatic_updates
  encryption_at_host_enabled                             = each.value.encryption_at_host_enabled
  eviction_policy                                        = each.value.eviction_policy
  extensions_time_budget                                 = each.value.extensions_time_budget

  dynamic "gallery_application" {
    for_each = coalesce(each.value.gallery_application, [])

    content {
      version_id             = gallery_application.value.version_id
      configuration_blob_uri = gallery_application.value.configuration_blob_uri
      order                  = gallery_application.value.order
      tag                    = gallery_application.value.tag
    }
  }

  hotpatching_enabled = each.value.hotpatching_enabled

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  license_type          = each.value.license_type
  max_bid_price         = each.value.max_bid_price
  patch_assessment_mode = each.value.patch_assessment_mode
  patch_mode            = each.value.patch_mode

  dynamic "plan" {
    for_each = try(each.value.plan, null) == null ? [] : [1]

    content {
      name      = each.value.plan.name
      product   = each.value.plan.product
      publisher = each.value.plan.publisher
    }
  }

  provision_vm_agent           = each.value.provision_vm_agent
  proximity_placement_group_id = each.value.proximity_placement_group_id
  reboot_setting               = each.value.reboot_setting

  secure_boot_enabled = each.value.secure_boot_enabled
  tags                = each.value.tags

  dynamic "termination_notification" {
    for_each = try(each.value.termination_notification, null) == null ? [] : [1]

    content {
      enabled = each.value.termination_notification.enabled
      timeout = each.value.termination_notification.timeout
    }
  }

  timezone                     = each.value.timezone
  user_data                    = each.value.user_data
  virtual_machine_scale_set_id = each.value.virtual_machine_scale_set_id
  vtpm_enabled                 = each.value.vtpm_enabled

  dynamic "winrm_listener" {
    for_each = coalesce(each.value.winrm_listener, [])

    content {
      protocol        = winrm_listener.value.protocol
      certificate_url = winrm_listener.value.certificate_url
    }
  }

  zone = each.value.zone
}
