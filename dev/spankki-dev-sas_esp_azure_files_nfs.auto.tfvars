#
# SAS ESP Azure Files NFS
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

/*
sas_esp_azure_files_nfs = {
  account = {
    "sas-esp-common-nfs" = {
      name                             = "spankkisasespnfsdev"
      resource_group_name              = "rg-shared-prod"
      location                         = "westeurope"
      account_kind                     = "FileStorage"
      account_tier                     = "Premium"
      account_replication_type         = "LRS"
      cross_tenant_replication_enabled = false
      enable_https_traffic_only        = true
      public_network_access_enabled    = false
      allow_nested_items_to_be_public  = false
      shared_access_key_enabled        = false
      local_user_enabled               = true
      min_tls_version                  = "TLS1_2"
      network_rules = {
        default_action = "Deny"
        bypass = [
          "AzureServices"
        ]
        virtual_network_subnet_ids = [
          "sas-esp-dev_sas-esp-dev-aks"
        ]
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
    }
  }
}

sas_esp_azure_files_nfs_private_endpoint = {
  private_endpoint = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
    #
    # Kafka
    #
    "sas-esp-common" = {
      name                = "endpoint-spankki-afc-esp-we-nfs-common-dev"
      resource_group_name = "rg-networking"
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
      subnet_id = "sas-esp-dev_sas-esp-dev-endpoint"
      private_service_connection = {
        name                           = "endpoint-spankki-afc-esp-we-nfs-common-dev"
        is_manual_connection           = false
        private_connection_resource_id = "storage-account-sas-esp-common-nfs"
        subresource_names = [
          "file"
        ]
      }
      ip_configuration = [
        {
          name               = "privatelink-nfs-common-dev"
          private_ip_address = "10.204.71.5"
          subresource_name   = "file"
        }
      ]
      private_dns_zone_group = {
        name = "privatelink-spankki-afc-esp-we-file-dev"
        private_dns_zone_ids = [
          "privatelink-file"
        ]
      }
    }
  }
}
*/
