#
# SAS ESP Azure Netapp Files
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

/*
sas_esp_anf = {
  account = {
    "sas-esp" = {
      name                = "anf-spankki-afc-esp-we-dev"
      resource_group_name = "rg-spankki-afc-esp-we-anf-dev"
      location            = "westeurope"
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
  pool = {
    "sas-esp-standard" = {
      account_name  = "sas-esp"
      name          = "anf-pool-spankki-afc-esp-we-standard-dev"
      service_level = "Standard"
      size_in_tb    = 2
      qos_type      = "Manual"
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
  volume = {
    "sas-esp-common" = {
      account_name               = "sas-esp"
      pool_name                  = "sas-esp-standard"
      name                       = "anf-volume-spankki-afc-esp-we-common-dev"
      zone                       = "1"
      volume_path                = "common"
      service_level              = "Standard"
      throughput_in_mibps        = 4
      subnet_id                  = "sas-esp-dev_sas-esp-dev-anf"
      network_features           = "Standard"
      protocols                  = ["NFSv4.1"]
      security_style             = "unix"
      storage_quota_in_gb        = 200
      snapshot_directory_visible = false
      export_policy_rule = [
        {
          rule_index = 1
          allowed_clients = [
            "10.204.70.0/23"
          ]
          protocols_enabled = [
            "NFSv4.1"
          ]
          unix_read_write     = true
          root_access_enabled = true
        }
      ]
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
*/
