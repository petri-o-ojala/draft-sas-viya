#
# Azure Managed Disks
#

locals {
  azurerm_managed_disk = azurerm_managed_disk.lz
}

resource "azurerm_managed_disk" "lz" {
  for_each = {
    for disk in local.azure_managed_disk : disk.resource_index => disk
  }

  name                 = each.value.name
  resource_group_name  = each.value.resource_group_name
  location             = each.value.location
  storage_account_type = each.value.storage_account_type
  create_option        = each.value.create_option
  tags                 = each.value.tags

  disk_encryption_set_id            = each.value.disk_encryption_set_id
  disk_iops_read_write              = each.value.disk_iops_read_write
  disk_mbps_read_write              = each.value.disk_mbps_read_write
  disk_iops_read_only               = each.value.disk_iops_read_only
  disk_mbps_read_only               = each.value.disk_mbps_read_only
  upload_size_bytes                 = each.value.upload_size_bytes
  disk_size_gb                      = each.value.disk_size_gb
  hyper_v_generation                = each.value.hyper_v_generation
  image_reference_id                = each.value.image_reference_id
  gallery_image_reference_id        = each.value.gallery_image_reference_id
  logical_sector_size               = each.value.logical_sector_size
  optimized_frequent_attach_enabled = each.value.optimized_frequent_attach_enabled
  performance_plus_enabled          = each.value.performance_plus_enabled
  os_type                           = each.value.os_type
  source_resource_id                = each.value.source_resource_id
  source_uri                        = each.value.source_uri
  storage_account_id                = each.value.storage_account_id
  tier                              = each.value.tier
  trusted_launch_enabled            = each.value.trusted_launch_enabled
  security_type                     = each.value.security_type
  secure_vm_disk_encryption_set_id  = each.value.secure_vm_disk_encryption_set_id
  on_demand_bursting_enabled        = each.value.on_demand_bursting_enabled
  network_access_policy             = each.value.network_access_policy
  disk_access_id                    = each.value.disk_access_id
  public_network_access_enabled     = each.value.public_network_access_enabled

  dynamic "encryption_settings" {
    for_each = try(each.value.encryption_settings, null) == null ? [] : [1]

    content {
      dynamic "disk_encryption_key" {
        for_each = try(each.value.encryption_settings.disk_encryption_key, null) == null ? [] : [1]

        content {
          secret_url      = each.value.encryption_settings.disk_encryption_key.secret_url
          source_vault_id = each.value.encryption_settings.disk_encryption_key.source_vault_id
        }
      }

      dynamic "key_encryption_key" {
        for_each = try(each.value.encryption_settings.key_encryption_key, null) == null ? [] : [1]

        content {
          key_url         = each.value.encryption_settings.key_encryption_key.key_url
          source_vault_id = each.value.encryption_settings.key_encryption_key.source_vault_id
        }
      }
    }
  }
}



resource "azurerm_virtual_machine_data_disk_attachment" "lz" {
  for_each = {
    for attachment in local.azure_virtual_machine_data_disk_attachment : attachment.resource_index => attachment
  }

  managed_disk_id           = each.value.managed_disk_id
  virtual_machine_id        = each.value.virtual_machine_id
  lun                       = each.value.lun
  caching                   = each.value.caching
  create_option             = each.value.create_option
  write_accelerator_enabled = each.value.write_accelerator_enabled
}
