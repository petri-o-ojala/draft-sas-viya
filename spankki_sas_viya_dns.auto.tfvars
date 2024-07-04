#
# SAS Viya Azure DNS
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>


sas_viya_dns = {
  private_zone = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone
    "privatelink-blob" = {
      name                = "privatelink.blob.core.windows.net"
      resource_group_name = "rg-spankki-afc-esp-we-network-dev"
      tags = {
        "terraform"  = "true"
        "managed_by" = "tietoevry"
      }
    },
    "privatelink-keyvault" = {
      name                = "privatelink.vaultcore.azure.net"
      resource_group_name = "rg-spankki-afc-esp-we-network-dev"
      tags = {
        "terraform"  = "true"
        "managed_by" = "tietoevry"
      }
    }
  }
  private_zone_vnet_link = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone_virtual_network_link
    "privatelink-blob" = {
      name                  = "sas-viya"
      private_dns_zone_name = "privatelink-blob"
      virtual_network_id    = "sas-viya-dev"
      resource_group_name   = "rg-spankki-afc-esp-we-network-dev"
      registration_enabled  = false
      tags = {
        "terraform"  = "true"
        "managed_by" = "tietoevry"
      }
    }
  }
}
