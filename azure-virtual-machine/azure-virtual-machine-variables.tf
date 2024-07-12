#
# Azure Windows Virtual Machines
#

variable "vm" {
  type = object({
    managed_disk = optional(map(object({
      name                              = string
      location                          = string
      resource_group_name               = string
      storage_account_type              = string
      create_option                     = string
      tags                              = optional(map(string))
      disk_encryption_set_id            = optional(string)
      disk_iops_read_write              = optional(number)
      disk_mbps_read_write              = optional(number)
      disk_iops_read_only               = optional(number)
      disk_mbps_read_only               = optional(number)
      upload_size_bytes                 = optional(number)
      disk_size_gb                      = optional(string)
      hyper_v_generation                = optional(string)
      image_reference_id                = optional(string)
      gallery_image_reference_id        = optional(string)
      logical_sector_size               = optional(number)
      optimized_frequent_attach_enabled = optional(bool)
      performance_plus_enabled          = optional(bool)
      os_type                           = optional(string)
      source_resource_id                = optional(string)
      source_uri                        = optional(string)
      storage_account_id                = optional(string)
      tier                              = optional(string)
      trusted_launch_enabled            = optional(bool)
      security_type                     = optional(string)
      secure_vm_disk_encryption_set_id  = optional(string)
      on_demand_bursting_enabled        = optional(bool)
      network_access_policy             = optional(string)
      disk_access_id                    = optional(string)
      public_network_access_enabled     = optional(bool)
      encryption_settings = optional(object({
        disk_encryption_key = optional(object({
          secret_url      = string
          source_vault_id = optional(string)
        }))
        key_encryption_key = optional(object({
          key_url         = string
          source_vault_id = optional(string)
        }))
      }))
      attachment = optional(object({
        virtual_machine_id        = string
        lun                       = number
        caching                   = string
        create_option             = optional(string)
        write_accelerator_enabled = optional(bool)
      }))
    })))
    datasource = optional(object({
      keyvault = optional(map(object({
        keyvault_id = optional(string)
        secret      = optional(list(string))
      })))
    }))
    network_interface = optional(map(object({
      name                          = string
      location                      = string
      resource_group_name           = string
      auxiliary_mode                = optional(string)
      auxiliary_sku                 = optional(string)
      dns_servers                   = optional(list(string))
      enable_ip_forwarding          = optional(bool)
      enable_accelerated_networking = optional(bool)
      internal_dns_name_label       = optional(string)
      ip_configuration = list(object({
        name                                               = string
        gateway_load_balancer_frontend_ip_configuration_id = optional(string)
        subnet_id                                          = optional(string)
        private_ip_address_version                         = optional(string)
        private_ip_address_allocation                      = optional(string)
        public_ip_address_id                               = optional(string)
        primary                                            = optional(bool)
        private_ip_address                                 = optional(string)
      }))
      tags = optional(map(string))
    })))
    linux_virtual_machine = optional(map(object({
      name                = string
      location            = string
      resource_group_name = string
      size                = string
      source_image_id     = optional(string)
      source_image_reference = optional(object({
        publisher = optional(string)
        offer     = optional(string)
        sku       = optional(string)
        version   = optional(string)
      }))
      os_disk = object({
        disk_size_gb                     = number
        storage_account_type             = optional(string)
        caching                          = string
        disk_encryption_set_id           = optional(string)
        name                             = optional(string)
        secure_vm_disk_encryption_set_id = optional(string)
        security_encryption_type         = optional(string)
        write_accelerator_enabled        = optional(bool)
      })
      additional_capabilities = optional(object({
        ultra_ssd_enabled = optional(bool)
      }))
      allow_extension_operations = optional(string)
      availability_set_id        = optional(string)
      boot_diagnostics = optional(object({
        storage_account_uri = optional(string)
      }))
      bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
      capacity_reservation_group_id                          = optional(string)
      computer_name                                          = optional(string)
      custom_data                                            = optional(string)
      dedicated_host_id                                      = optional(string)
      dedicated_host_group_id                                = optional(string)
      enable_automatic_updates                               = optional(bool)
      encryption_at_host_enabled                             = optional(bool)
      eviction_policy                                        = optional(string)
      extensions_time_budget                                 = optional(string)
      gallery_application = optional(list(object({
        version_id             = optional(string)
        configuration_blob_uri = optional(string)
        order                  = optional(number)
        tag                    = optional(string)
      })))
      hotpatching_enabled = optional(bool)
      identity = optional(object({
        type         = optional(string)
        identity_ids = optional(list(string))
      }))
      license_type          = optional(string)
      max_bid_price         = optional(string)
      patch_assessment_mode = optional(string)
      patch_mode            = optional(string)
      plan = optional(object({
        name      = optional(string)
        product   = optional(string)
        publisher = optional(string)
      }))
      provision_vm_agent           = optional(bool)
      proximity_placement_group_id = optional(string)
      reboot_setting               = optional(string)
      secure_boot_enabled          = optional(bool)
      tags                         = optional(map(string))
      termination_notification = optional(object({
        enabled = optional(bool)
        timeout = optional(number)
      }))
      timezone                        = optional(string)
      user_data                       = optional(string)
      virtual_machine_scale_set_id    = optional(string)
      vtpm_enabled                    = optional(bool)
      admin_username                  = optional(string)
      admin_password                  = optional(string)
      disable_password_authentication = optional(bool)
      admin_ssh_key = optional(list(object({
        username   = string
        public_key = string
      })))
      zone                  = optional(string)
      network_interface_ids = optional(list(string))
      extension = optional(map(object({
        name                        = string
        publisher                   = string
        type                        = string
        type_handler_version        = optional(string)
        auto_upgrade_minor_version  = optional(bool)
        automatic_upgrade_enabled   = optional(bool)
        settings                    = optional(map(any))
        failure_suppression_enabled = optional(bool)
        protected_settings          = optional(map(any))
        protected_settings_from_key_vault = optional(object({
          secret_url      = optional(string)
          source_vault_id = optional(string)
        }))
        provision_after_extensions = optional(list(string))
        tags                       = optional(map(string))
      })))
      policy = optional(map(object({
        name     = string
        location = optional(string)
        configuration = object({
          assignment_type = optional(string)
          content_hash    = optional(string)
          content_uri     = optional(string)
          version         = optional(string)
          parameter = optional(list(object({
            name  = string
            value = string
          })))
        })
      })))
    })))
    windows_virtual_machine = optional(map(object({
      name                = string
      location            = string
      resource_group_name = string
      size                = string
      source_image_id     = optional(string)
      source_image_reference = optional(object({
        publisher = optional(string)
        offer     = optional(string)
        sku       = optional(string)
        version   = optional(string)
      }))
      os_disk = object({
        disk_size_gb                     = number
        storage_account_type             = optional(string)
        caching                          = string
        disk_encryption_set_id           = optional(string)
        name                             = optional(string)
        secure_vm_disk_encryption_set_id = optional(string)
        security_encryption_type         = optional(string)
        write_accelerator_enabled        = optional(bool)
      })
      additional_capabilities = optional(object({
        ultra_ssd_enabled = optional(bool)
      }))
      allow_extension_operations = optional(string)
      availability_set_id        = optional(string)
      boot_diagnostics = optional(object({
        storage_account_uri = optional(string)
      }))
      bypass_platform_safety_checks_on_user_schedule_enabled = optional(bool)
      capacity_reservation_group_id                          = optional(string)
      computer_name                                          = optional(string)
      custom_data                                            = optional(string)
      dedicated_host_id                                      = optional(string)
      dedicated_host_group_id                                = optional(string)
      enable_automatic_updates                               = optional(bool)
      encryption_at_host_enabled                             = optional(bool)
      eviction_policy                                        = optional(string)
      extensions_time_budget                                 = optional(string)
      gallery_application = optional(list(object({
        version_id             = optional(string)
        configuration_blob_uri = optional(string)
        order                  = optional(number)
        tag                    = optional(string)
      })))
      hotpatching_enabled = optional(bool)
      identity = optional(object({
        type         = optional(string)
        identity_ids = optional(list(string))
      }))
      license_type          = optional(string)
      max_bid_price         = optional(string)
      patch_assessment_mode = optional(string)
      patch_mode            = optional(string)
      plan = optional(object({
        name      = optional(string)
        product   = optional(string)
        publisher = optional(string)
      }))
      provision_vm_agent           = optional(bool)
      proximity_placement_group_id = optional(string)
      reboot_setting               = optional(string)
      secure_boot_enabled          = optional(bool)
      tags                         = optional(map(string))
      termination_notification = optional(object({
        enabled = optional(bool)
        timeout = optional(number)
      }))
      timezone                     = optional(string)
      user_data                    = optional(string)
      virtual_machine_scale_set_id = optional(string)
      vtpm_enabled                 = optional(bool)
      winrm_listener = optional(list(object({
        protocol        = optional(string)
        certificate_url = optional(string)
      })))
      admin_username        = optional(string)
      admin_password        = optional(string)
      zone                  = optional(string)
      network_interface_ids = optional(list(string))
      extension = optional(map(object({
        name                        = string
        publisher                   = string
        type                        = string
        type_handler_version        = optional(string)
        auto_upgrade_minor_version  = optional(bool)
        automatic_upgrade_enabled   = optional(bool)
        settings                    = optional(map(any))
        failure_suppression_enabled = optional(bool)
        protected_settings          = optional(map(any))
        protected_settings_from_key_vault = optional(object({
          secret_url      = optional(string)
          source_vault_id = optional(string)
        }))
        provision_after_extensions = optional(list(string))
        tags                       = optional(map(string))
      })))
      policy = optional(map(object({
        name     = string
        location = optional(string)
        configuration = object({
          assignment_type = optional(string)
          content_hash    = optional(string)
          content_uri     = optional(string)
          version         = optional(string)
          parameter = optional(list(object({
            name  = string
            value = string
          })))
        })
      })))
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
  # Azure Windows Virtual Machines
  #
  azure_windows_virtual_machine = flatten([
    for vm_id, vm in coalesce(try(var.vm.windows_virtual_machine, null), {}) : merge(
      vm,
      {
        resource_index = join("_", [vm_id])
      }
    )
  ])

  #
  # Azure Windows Virtual Machine Extensions
  #
  azure_windows_virtual_machine_extension = flatten([
    for vm_id, vm in coalesce(try(var.vm.windows_virtual_machine, null), {}) : [
      for extension_id, extension in coalesce(vm.extension, {}) : merge(
        extension,
        {
          vm_id              = vm_id
          extension_id       = extension_id
          virtual_machine_id = local.azurerm_windows_virtual_machine[vm_id].id
          vm                 = vm
          resource_index     = join("_", [vm_id, extension_id])
        }
      )
    ]
  ])

  #
  # Guest Configuration Policy assignments for Windows Virtual Machines
  #
  azure_windows_virtual_machine_policy = flatten([
    for vm_id, vm in coalesce(try(var.vm.windows_virtual_machine, null), {}) : [
      for policy_id, policy in coalesce(vm.policy, {}) : merge(
        policy,
        {
          vm_id              = vm_id
          vm                 = vm
          policy_id          = policy_id
          virtual_machine_id = local.azurerm_windows_virtual_machine[vm_id].id
          location           = local.azurerm_windows_virtual_machine[vm_id].location
          resource_index     = join("_", [vm_id, policy_id])
        }
      )
    ]
  ])

  #
  # Azure Linux Virtual Machines
  #
  azure_linux_virtual_machine = flatten([
    for vm_id, vm in coalesce(try(var.vm.linux_virtual_machine, null), {}) : merge(
      vm,
      {
        resource_index = join("_", [vm_id])
      }
    )
  ])

  #
  # Azure Linux Virtual Machine Extensions
  #
  azure_linux_virtual_machine_extension = flatten([
    for vm_id, vm in coalesce(try(var.vm.linux_virtual_machine, null), {}) : [
      for extension_id, extension in coalesce(vm.extension, {}) : merge(
        extension,
        {
          vm_id              = vm_id
          extension_id       = extension_id
          virtual_machine_id = local.azurerm_linux_virtual_machine[vm_id].id
          vm                 = vm
          resource_index     = join("_", [vm_id, extension_id])
        }
      )
    ]
  ])

  #
  # Guest Configuration Policy assignments for Linux Virtual Machines
  #
  azure_linux_virtual_machine_policy = flatten([
    for vm_id, vm in coalesce(try(var.vm.linux_virtual_machine, null), {}) : [
      for policy_id, policy in coalesce(vm.policy, {}) : merge(
        policy,
        {
          vm_id              = vm_id
          vm                 = vm
          policy_id          = policy_id
          virtual_machine_id = local.azurerm_linux_virtual_machine[vm_id].id
          location           = local.azurerm_linux_virtual_machine[vm_id].location
          resource_index     = join("_", [vm_id, policy_id])
        }
      )
    ]
  ])

  #
  # Azure Managed Disks
  #
  azure_managed_disk = flatten([
    for disk_id, disk in coalesce(try(var.vm.managed_disk, null), {}) : merge(
      disk,
      {
        resource_index = join("_", [disk_id])
      }
    )
  ])

  azure_virtual_machine_data_disk_attachment = flatten([
    for disk_id, disk in coalesce(try(var.vm.managed_disk, null), {}) : merge(
      disk.attachment,
      {
        virtual_machine_id = lookup(local.azurerm_virtual_machine, disk.attachment.virtual_machine_id, null) == null ? disk.attachment.virtual_machine_id : local.azurerm_virtual_machine[disk.attachment.virtual_machine_id].id
        managed_disk_id    = local.azurerm_managed_disk[disk_id].id
        resource_index     = join("_", [disk_id])
      }
    )
    if disk.attachment != null
  ])
}
