#
# SAS ESP Azure Network Security
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_network_security_group = {
  group = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group
    "sas-esp-aks" = {
      name                = "spankki-nsg-afc-dev-we-internal-01"
      resource_group_name = "rg-networking"
      location            = "westeurope"
    }
  }
  #
  #
  #
  rule = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule
    #
    # Allow internal AKS traffic frely in the AKS subnet CIDR range
    #
    "AllowLocalAKS" = {
      network_security_group_name = "spankki-nsg-afc-dev-we-internal-01"
      resource_group_name         = "rg-networking"
      location                    = "westeurope"
      access                      = "Deny"
      destination_address_prefix  = "10.204.70.0/24"
      destination_port_range      = "*"
      direction                   = "Inbound"
      name                        = "AllowLocalAKS"
      priority                    = 2000
      protocol                    = "*"
      source_address_prefix       = "10.204.70.0/24"
      source_port_range           = "*"
    },
    #
    # Deny all VNet traffic by default
    #
    "DenyLocalVirtualNetwork" = {
      network_security_group_name = "spankki-nsg-afc-dev-we-internal-01"
      resource_group_name         = "rg-networking"
      location                    = "westeurope"
      access                      = "Deny"
      destination_address_prefix  = "*"
      destination_port_range      = "*"
      direction                   = "Inbound"
      name                        = "DenyLocalVirtualNetwork"
      priority                    = 3000
      protocol                    = "*"
      source_address_prefix       = "10.204.70.0/23"
      source_port_range           = "*"
    }
  }
}
