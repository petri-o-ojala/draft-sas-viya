#
# SAS Viya Resource Groups
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_viya_resource_group = {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
  "sas-viya-common" = {
    name     = "rg-spankki-afc-esp-we-common-dev"
    location = "westeurope"
    tags = {
      "terraform"  = "true"
      "managed_by" = "tietoevry"
    }
    #management_lock = {}
  }
  "sas-viya-network" = {
    name     = "rg-spankki-afc-esp-we-network-dev"
    location = "westeurope"
    tags = {
      "terraform"  = "true"
      "managed_by" = "tietoevry"
    }
    #management_lock = {}
  }
  "sas-viya-aks" = {
    name     = "rg-spankki-afc-esp-we-aks-dev"
    location = "westeurope"
    tags = {
      "terraform"  = "true"
      "managed_by" = "tietoevry"
    }
    #management_lock = {}
  }
  "sas-viya-servicebus" = {
    name     = "rg-spankki-afc-esp-we-servicebus-dev"
    location = "westeurope"
    tags = {
      "terraform"  = "true"
      "managed_by" = "tietoevry"
    }
    #management_lock = {}
  }
  "sas-viya-acr" = {
    name     = "rg-spankki-afc-esp-we-acr-dev"
    location = "westeurope"
    tags = {
      "terraform"  = "true"
      "managed_by" = "tietoevry"
    }
    #management_lock = {}
  }
  "sas-viya-anf" = {
    name     = "rg-spankki-afc-esp-we-anf-dev"
    location = "westeurope"
    tags = {
      "terraform"  = "true"
      "managed_by" = "tietoevry"
    }
    #management_lock = {}
  }
}
