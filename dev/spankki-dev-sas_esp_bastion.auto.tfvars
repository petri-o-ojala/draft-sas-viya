#
# SAS ESP Azure Virtual Machine for Bastion
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_vm_bastion_keyvault = {
  /*
  secret = {
    "bastion-admin-user" = {
      key_vault_id = "sas-esp"
      name         = "spankki-sp-afc-dev-bastion-admin-username"
      content_type = "Username"
      value        = "bastion-admin"
    }
    "bastion-admin-password" = {
      key_vault_id = "sas-esp"
      name         = "spankki-sp-afc-dev-bastion-admin-password"
      content_type = "Password"
      random_password = {
        length      = 16
        min_upper   = 2
        min_lower   = 2
        min_numeric = 2
        special     = false
      }
    }
  }
*/
}

sas_esp_vm_bastion_identity = {
  user_assigned = {
    "sas-esp-bastion" = {
      name                = "identity-spankki-afc-esp-we-vm-bastion-dev"
      location            = "westeurope"
      resource_group_name = "rg-spankki-afc-esp-we-identity-dev"
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
  }
}

sas_esp_vm_bastion = {
  network_interface = {
    "sas-esp-bastion" = {
      name                = "nic-spankki-afc-esp-we-bastion-dev"
      location            = "westeurope"
      resource_group_name = "rg-spankki-afc-esp-we-common-dev"
      ip_configuration = [
        {
          name                          = "ipconfig1"
          primary                       = true
          private_ip_address_allocation = "Static"
          private_ip_address_version    = "IPv4"
          private_ip_address            = "10.204.70.240"
          subnet_id                     = "sas-esp-dev_sas-esp-dev-aks"
        }
      ]
    }
  }
  /*
  linux_virtual_machine = {
    "sas-esp-bastion" = {
      name                = "vm-spankki-afc-esp-we-bastion-dev"
      location            = "westeurope"
      resource_group_name = "rg-spankki-afc-esp-we-common-dev"
      identity = {
        type = "UserAssigned"
        identity_ids = [
          "/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-identity-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-spankki-afc-esp-we-vm-bastion-dev"
        ]
      }
      size = "Standard_D4s_v4"
      source_image_reference = {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "19.04"
        version   = "latest"
      }
      os_disk = {
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 128
        caching              = "ReadWrite"
      }
      computer_name                   = "dev-bastion"
      admin_username                  = "te-admin"
      disable_password_authentication = true
      admin_ssh_key = [
        {
          username   = "linuxadmin"
          public_key = "~/.ssh/id_rsa.pub"
        }
      ]
      provision_vm_agent       = true
      enable_automatic_updates = true
      patch_assessment_mode    = "ImageDefault"
      patch_mode               = "ImageDefault"
      network_interface_ids = [
        "sas-esp-bastion"
      ]
      boot_diagnostics = {
        storage_account_uri = null
      }
    }
  }
  /*
  windows_virtual_machine = {
    "sas-esp-bastion" = {
      name                = "vm-spankki-afc-esp-we-bastion-dev"
      location            = "westeurope"
      resource_group_name = "rg-spankki-afc-esp-we-common-dev"
      identity = {
        type = "UserAssigned"
        identity_ids = [
          "/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-identity-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-spankki-afc-esp-we-vm-bastion-dev"
        ]
      }
      size = "Standard_D4s_v4"
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"
        offer     = "WindowsServer"
        sku       = "2019-Datacenter"
        version   = "latest"
      }
      os_disk = {
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 128
        caching              = "ReadWrite"
      }
      computer_name            = "bastion-dev-vm"
      admin_username           = "bastionadmin"
      admin_password           = "H@Sh1CoR3!"
      provision_vm_agent       = true
      enable_automatic_updates = true
      patch_assessment_mode    = "ImageDefault"
      patch_mode               = "AutomaticByOS"
      network_interface_ids = [
        "sas-esp-bastion"
      ]
      boot_diagnostics = {
        storage_account_uri = null
      }
      extension = {
        "GuestConfigForWindows" = {
          name                       = "GuestConfigForWindows"
          publisher                  = "Microsoft.GuestConfiguration"
          type                       = "ConfigurationforWindows"
          type_handler_version       = "1.0"
          auto_upgrade_minor_version = true
          automatic_upgrade_enabled  = true
        }
        "AzureNetworkWatcherExtension" = {
          name                       = "AzureNetworkWatcherExtension"
          publisher                  = "Microsoft.Azure.NetworkWatcher"
          type                       = "NetworkWatcherAgentWindows"
          type_handler_version       = "1.4"
          auto_upgrade_minor_version = true
        }
        "AzureMonitorWindowsAgent" = {
          name                       = "AzureMonitorWindowsAgent"
          publisher                  = "Microsoft.Azure.Monitor"
          type                       = "AzureMonitorWindowsAgent"
          type_handler_version       = "1.0"
          auto_upgrade_minor_version = true
          automatic_upgrade_enabled  = true
        }
        "DependencyAgentWindows" = {
          name                       = "DAExtension"
          publisher                  = "Microsoft.Azure.Monitoring.DependencyAgent"
          type                       = "DependencyAgentWindows"
          type_handler_version       = "9.10"
          auto_upgrade_minor_version = true
          settings = {
            "enableAMA" : "true"
          }
        }
      }
    }
  }
  */
  # }
}
