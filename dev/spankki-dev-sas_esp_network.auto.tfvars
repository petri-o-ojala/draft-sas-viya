#
# SAS ESP Azure Networking
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>


sas_esp_network = {
  vnet = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network
    "sas-esp-dev" = {
      name                = "spankki-vnet-afc-dev-we-internal-01"
      resource_group_name = "rg-networking"
      location            = "westeurope"
      address_space = [
        "10.204.70.0/23"
      ]
      subnet = {
        # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet
        #
        # Subnet for AKS
        "sas-esp-dev-aks" = {
          name = "spankki-subnet-afc-esp-we-aks-dev-01"
          address_prefixes = [
            "10.204.70.0/24"
          ]
          service_endpoints = [
            "Microsoft.Storage",
            "Microsoft.KeyVault"
          ]
        },
        # 
        # Subnet for Private Endpoints
        "sas-esp-dev-endpoint" = {
          name = "snet-spankki-afc-esp-we-endpoint-dev-01"
          address_prefixes = [
            "10.204.71.0/26"
          ]
        },
        #
        # Subnet for Azure NetApp Files
        "sas-esp-dev-anf" = {
          name = "snet-spankki-afc-esp-we-anf-dev-01"
          address_prefixes = [
            "10.204.71.64/26"
          ]
          delegation = [
            {
              name = "sas-esp-anf"
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
        #
        # Subnet for Azure PostgreSQL
        "sas-esp-dev-postgresql" = {
          name = "snet-spankki-afc-esp-we-postgresql-dev-01"
          address_prefixes = [
            "10.204.71.128/26"
          ]
          service_endpoints = [
            "Microsoft.Storage"
          ]
          delegation = [
            {
              name = "sas-esp-postgresql"
              service_delegation = {
                name = "Microsoft.DBforPostgreSQL/flexibleServers"
                actions = [
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
