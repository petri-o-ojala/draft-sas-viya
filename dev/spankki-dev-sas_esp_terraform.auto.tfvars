
#
# SAS ESP Azure Service Bus
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>
#

sas_esp_tietoevry_azure_terraform = {
  resource_group = {
    "terraform" = {
      name     = "rg-spankki-afc-esp-we-terraform-dev"
      location = "westeurope"
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
  storage = {
    account = {
      "terraform-state" = {
        name                             = "tfspankkisasespdev"
        resource_group_name              = "rg-spankki-afc-esp-we-terraform-dev"
        location                         = "westeurope"
        account_kind                     = "StorageV2"
        account_tier                     = "Standard"
        account_replication_type         = "LRS"
        cross_tenant_replication_enabled = false
        enable_https_traffic_only        = true
        default_to_oauth_authentication  = true
        shared_access_key_enabled        = false
        allow_nested_items_to_be_public  = false
        network_rules = {
          default_action = "Deny"
          ip_rules = [
            "88.114.194.4"
          ]
        }
        blob_properties = {
          versioning_enabled = true
        }
        tags = {
          "application" = "AFC"
          "contact"     = "anssi.yli-leppala@s-pankki.fi"
          "costcenter"  = "3730403"
          "department"  = "S-Pankki"
          "environment" = "dev"
          "terraform"   = "true"
          "managed_by"  = "tietoevry"
        }
        /*
        container = [
          {
            name = "tf-state-sas-esp-dev"
            iam = [
              {
                role_definition_name = "Storage Blob Data Contributor"
                principal_id = [
                  "tietoevry-azure-sas-esp-dev"
                ]
              }
            ]
          }
        ]
*/
      }
    }
  }
}
