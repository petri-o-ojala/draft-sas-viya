#
# SAS ESP Resource Groups
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_resource_group = {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group
  "sas-esp-shared" = {
    name     = "rg-shared-prod"
    location = "westeurope"
    tags = {
      "CI_PROJECT_URL" = "https://gitlab.sok.fi/general-infrastructure/azure-cybercom-deployments/subscriptions/s-pankki_afc_dev"
      "application"    = "AFC"
      "contact"        = "anssi.yli-leppala@s-pankki.fi"
      "costcenter"     = "3730403"
      "department"     = "S-Pankki"
      "environment"    = "dev"
    }
    #management_lock = {}
  }
  "sas-esp-network" = {
    name     = "rg-networking"
    location = "westeurope"
    tags = {
      "application"  = "AFC"
      "contact"      = "anssi.yli-leppala@s-pankki.fi"
      "costcenter"   = "3730403"
      "environment"  = "dev"
      "personaldata" = "false"
    }
    #management_lock = {}
  }
  "sas-esp-keyvault" = {
    name     = "rg-ade-keys-prod"
    location = "westeurope"
    tags = {
      "CI_PROJECT_URL" = "https://gitlab.sok.fi/general-infrastructure/azure-cybercom-deployments/subscriptions/s-pankki_afc_dev"
      "application"    = "AFC"
      "contact"        = "anssi.yli-leppala@s-pankki.fi"
      "costcenter"     = "3730403"
      "department"     = "S-Pankki"
      "environment"    = "dev"
    }
    #management_lock = {}
  }
  #
  # SAS ESP User-managed Identities
  #
  "sas-esp-identity" = {
    name     = "rg-spankki-afc-esp-we-identity-dev"
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
    #management_lock = {}
  }
  #
  # SAS ESP Resource Groups
  #
  "sas-esp-aks" = {
    name     = "rg-spankki-afc-esp-we-aks-dev"
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
    #management_lock = {}
  }
  /*
  "sas-esp-aks-nodes" = {
    name     = "rg-spankki-afc-esp-we-aks-nodes-dev"
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
    #management_lock = {}
  }
*/
  "sas-esp-servicebus" = {
    name     = "rg-spankki-afc-esp-we-servicebus-dev"
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
    #management_lock = {}
  }
  "sas-esp-postgresql" = {
    name     = "rg-spankki-afc-esp-we-postgresql-dev"
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
    #management_lock = {}
  }
  "sas-esp-acr" = {
    name     = "rg-spankki-afc-esp-we-acr-dev"
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
    #management_lock = {}
  }
  "sas-esp-anf" = {
    name     = "rg-spankki-afc-esp-we-anf-dev"
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
    #management_lock = {}
  }
}
