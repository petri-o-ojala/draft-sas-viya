#
# SAS ESP Azure Virtual Machine for Bastion
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_vm_bastion_keyvault = {
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
}

sas_esp_vm_bastion_identity = {
  user_assigned = {
    "sas-esp-bastion" = {
      name                = "identity-spankki-afc-esp-we-vm-bastion-dev"
      location            = "westeurope"
      resource_group_name = "rg-spankki-afc-esp-we-identity-dev"
      tags = {
        "application" = "S-Pankki AFC ESP"
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
  managed_disk = {
    "sas-esp-bastion-data" = {
      name                          = "nic-spankki-afc-esp-we-bastion-dev"
      location                      = "westeurope"
      resource_group_name           = "rg-spankki-afc-esp-we-common-dev"
      storage_account_type          = "StandardSSD_LRS"
      create_option                 = "Empty"
      disk_size_gb                  = "32"
      public_network_access_enabled = false
      attachment = {
        virtual_machine_id = "sas-esp-bastion"
        lun                = 2
        caching            = "ReadWrite"
      }
      tags = {
        "application" = "S-Pankki AFC ESP"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    }
  }
  datasource = {
    keyvault = {
      "sas-esp" = {
        secret = [
          "spankki-sp-afc-dev-bastion-admin-username",
          "spankki-sp-afc-dev-bastion-admin-password"
        ]
      }
    }
  }
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
      size = "Standard_D2_v5"
      source_image_reference = {
        publisher = "erockyenterprisesoftwarefoundationinc1653071250513"
        offer     = "rockylinux-9"
        sku       = "rockylinux-9"
        version   = "latest"
      }
      plan = {
        name      = "rockylinux-9"
        product   = "rockylinux-9"
        publisher = "erockyenterprisesoftwarefoundationinc1653071250513"
      }
      os_disk = {
        storage_account_type = "StandardSSD_LRS"
        disk_size_gb         = 64
        caching              = "ReadWrite"
      }
      computer_name                   = "dev-bastion"
      admin_username                  = "sas-esp:spankki-sp-afc-dev-bastion-admin-username"
      admin_password                  = "sas-esp:spankki-sp-afc-dev-bastion-admin-password"
      disable_password_authentication = false
      provision_vm_agent              = true
      enable_automatic_updates        = true
      patch_assessment_mode           = "ImageDefault"
      patch_mode                      = "ImageDefault"
      network_interface_ids = [
        "sas-esp-bastion"
      ]
      boot_diagnostics = {
        storage_account_uri = null
      }
      extension = {
        "MicrosoftGuestConfiguration" = {
          name : "MicrosoftGuestConfiguration",
          publisher : "Microsoft.GuestConfiguration",
          type : "ConfigurationforLinux",
          type_handler_version : "1.0",
          auto_upgrade_minor_version : true
        },
        "AzureMonitorLinuxAgent" = {
          name : "AzureMonitorLinuxAgent",
          publisher : "Microsoft.Azure.Monitor",
          type : "AzureMonitorLinuxAgent",
          type_handler_version : "1.31",
          auto_upgrade_minor_version : true
        }
      }
    }
  }
}
