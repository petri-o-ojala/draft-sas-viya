
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
  storage_private_endpoint = {
    private_endpoint = {
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
      #
      # Kafka
      #
      "terraform-state" = {
        name                = "endpoint-spankki-afc-esp-we-terraform-state-dev"
        resource_group_name = "rg-spankki-afc-esp-we-terraform-dev"
        location            = "westeurope"
        tags = {
          "application" = "S-Pankki AFC ESP"
          "contact"     = "anssi.yli-leppala@s-pankki.fi"
          "costcenter"  = "3730403"
          "department"  = "S-Pankki"
          "environment" = "dev"
          "terraform"   = "true"
          "managed_by"  = "tietoevry"
        }
        subnet_id = "sas-esp-dev_sas-esp-dev-endpoint"
        private_service_connection = {
          name                           = "endpoint-spankki-afc-esp-we-nfs-common-dev"
          is_manual_connection           = false
          private_connection_resource_id = "storage-account-terraform-state"
          subresource_names = [
            "blob"
          ]
        }
        ip_configuration = [
          {
            name               = "privatelink-storage-terraform-state-dev"
            private_ip_address = "10.204.71.6"
            subresource_name   = "blob"
          }
        ]

        #
        # Deployed through policy, only for drift control
        #private_dns_zone_group = {
        #  name = "deployedByPolicy"
        #  private_dns_zone_ids = [
        #    "/subscriptions/d8e6d4cc-0f13-4246-a43d-8875ee1a6165/resourceGroups/rg-sok-private-dns-prod/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"
        #  ]
        #}
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
            "88.114.194.49",
            "85.29.92.90",
            "46.132.29.118"
          ]
        }
        blob_properties = {
          versioning_enabled = true
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
        container = [
          {
            name = "tf-state-sas-esp-dev"
            /*
            iam = [
              {
                role_definition_name = "Storage Blob Data Contributor"
                principal_id = [
                  "tietoevry-azure-sas-esp-dev"
                ]
              }
            ]
*/
          }
        ]
      }
    }
  }
}
