#
# SAS Viya Azure Networking
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>


sas_viya_network = {
  vnet = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
    "sas-viya-dev" = {
      name                = "vnet-spankki-afc-esp-we-sas-dev"
      resource_group_name = "rg-spankki-afc-esp-we-network-dev"
      location            = "westeurope"
      address_space = [
        "10.10.0.0/16"
      ]
      tags = {
        "terraform"  = "true"
        "managed_by" = "tietoevry"
      }
      subnet = {
        # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
        "sas-viya-dev-aks" = {
          name = "snet-spankki-afc-esp-we-aks-dev"
          address_prefixes = [
            "10.10.0.0/24"
          ]
          service_endpoints = [
            "Microsoft.Storage",
            "Microsoft.KeyVault"
          ]
        },
        "sas-viya-dev-endpoint" = {
          name = "snet-spankki-afc-esp-we-endpoint-dev"
          address_prefixes = [
            "10.10.2.0/24"
          ]
        },
        "sas-viya-dev-anf" = {
          name = "snet-spankki-afc-esp-we-anf-dev"
          address_prefixes = [
            "10.10.1.0/24"
          ]
          delegation = [
            {
              name = "sas-viya-anf"
              service_delegation = {
                name = "Microsoft.Netapp/volumes"
                actions = [
                  "Microsoft.Network/networkinterfaces/*",
                  "Microsoft.Network/virtualNetworks/subnets/join/action"
                ]
              }
            }
          ]
        }
      }
    }
  }
}
