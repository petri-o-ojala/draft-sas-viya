#
# SAS ESP Azure DNS
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

#
# Is there automation to deploy privatelink DNS zones centrally, or should we use resource_name.privatelink.domain locally?
#

sas_esp_dns = {
  private_zone = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
    "privatelink-blob" = {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "rg-networking"
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    },
    "privatelink-file" = {
      name                = "privatelink.file.core.windows.net"
      resource_group_name = "rg-networking"
      tags = {
        "application" = "AFC"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
    },
    "privatelink-postgresql" = {
      name                = "privatelink.postgres.database.azure.com"
      resource_group_name = "rg-networking"
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
    "privatelink-confluent-kafka" = {
      name                = "domdevcjpe9570w.eastus2.azure.devel.cpdev.cloud"
      resource_group_name = "rg-networking"
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
    "privatelink-aks" = {
      name                = "privatelink.westeurope.azmk8s.io"
      resource_group_name = "rg-networking"
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
  private_zone_vnet_link = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link
    "privatelink-blob" = {
      name                  = "sas-esp"
      private_dns_zone_name = "privatelink-blob"
      virtual_network_id    = "sas-esp-dev"
      resource_group_name   = "rg-networking"
      registration_enabled  = false
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
    "privatelink-file" = {
      name                  = "sas-esp"
      private_dns_zone_name = "privatelink-file"
      virtual_network_id    = "sas-esp-dev"
      resource_group_name   = "rg-networking"
      registration_enabled  = false
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
    "privatelink-postgresql" = {
      name                  = "sas-esp"
      private_dns_zone_name = "privatelink-postgresql"
      virtual_network_id    = "sas-esp-dev"
      resource_group_name   = "rg-networking"
      registration_enabled  = false
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
    "privatelink-aks" = {
      name                  = "sas-esp"
      private_dns_zone_name = "privatelink-aks"
      virtual_network_id    = "sas-esp-dev"
      resource_group_name   = "rg-networking"
      registration_enabled  = false
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
    "privatelink-confluent-kafka" = {
      name                  = "sas-esp"
      private_dns_zone_name = "privatelink-confluent-kafka"
      virtual_network_id    = "sas-esp-dev"
      resource_group_name   = "rg-networking"
      registration_enabled  = false
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
