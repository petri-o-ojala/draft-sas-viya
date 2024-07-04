#
# SAS Viya Azure Netapp Files
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_viya_anf = {
  account = {
    "sas-viya" = {
      name                = "anf-spankki-afc-esp-we-dev"
      resource_group_name = "rg-spankki-afc-esp-we-anf-dev"
      location            = "westeurope"
    }
  }
  pool = {
    "sas-viya-standard" = {
      account_name  = "sas-viya"
      name          = "anf-pool-spankki-afc-esp-we-standard-dev"
      service_level = "Standard"
      size_in_tb    = 2
      qos_type      = "Manual"
    }
    "sas-viya-premium" = {
      account_name  = "sas-viya"
      name          = "anf-pool-spankki-afc-esp-we-premium-dev"
      service_level = "Premium"
      size_in_tb    = 2
      qos_type      = "Manual"
    }
  }
  volume = {
    "sas-viya-common" = {
      account_name               = "sas-viya"
      pool_name                  = "sas-viya-standard"
      name                       = "anf-volume-spankki-afc-esp-we-common-dev"
      zone                       = "1"
      volume_path                = "common"
      service_level              = "Standard"
      subnet_id                  = "/subscriptions/b6f220d6-473b-4f8a-a8d5-bbfdf652a0df/resourceGroups/rg-ismok-bicep-dev/providers/Microsoft.Network/virtualNetworks/testvnet/subnets/subnet1"
      network_features           = "Standard"
      protocols                  = ["NFSv4.1"]
      security_style             = "unix"
      storage_quota_in_gb        = 100
      snapshot_directory_visible = false
      export_policy_rule = [
        {
          rule_index = 1
          allowed_clients = [
            "10.0.0.0/16"
          ]
          protocols_enabled = [
            "NFSv4.1"
          ]
          unix_read_write     = true
          root_access_enabled = true
        }
      ]
      quota_rule = [
        {
          name              = "quota-rule-developers"
          location          = "westeurope"
          quota_size_in_kib = 256
          quota_type        = "DefaultGroupQuota"
          quota_target      = 42
        }
      ]
    }
    "sas-viya-data" = {
      account_name               = "sas-viya"
      pool_name                  = "sas-viya-premium"
      name                       = "anf-volume-spankki-afc-esp-we-data-dev"
      zone                       = "1"
      volume_path                = "data"
      service_level              = "Premium"
      subnet_id                  = "/subscriptions/b6f220d6-473b-4f8a-a8d5-bbfdf652a0df/resourceGroups/rg-ismok-bicep-dev/providers/Microsoft.Network/virtualNetworks/testvnet/subnets/subnet1"
      network_features           = "Standard"
      protocols                  = ["CIFS"]
      security_style             = "unix"
      storage_quota_in_gb        = 100
      snapshot_directory_visible = false
      export_policy_rule = [
        {
          rule_index = 1
          allowed_clients = [
            "172.17.2.0/24"
          ]
          protocols_enabled = [
            "CIFS"
          ]
        }
      ]
    }
  }
}
