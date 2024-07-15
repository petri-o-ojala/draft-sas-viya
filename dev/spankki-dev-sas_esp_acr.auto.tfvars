#
# SAS ESP Azure Container Registry
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_esp_acr_identity = {
  user_assigned = {
    "sas-esp" = {
      name                = "identity-spankki-afc-esp-we-acr-dev"
      location            = "westeurope"
      resource_group_name = "rg-spankki-afc-esp-we-identity-dev"
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
}

sas_esp_acr = {
  registry = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
    "sas-esp" = {
      resource_group_name = "rg-spankki-afc-esp-we-acr-dev"
      location            = "westeurope"
      name                = "spankkisasdev"
      sku                 = "Standard"
      admin_enabled       = false
      identity = {
        type = "SystemAssigned, UserAssigned"
        identity_ids = [
          "/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-identity-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-spankki-afc-esp-we-acr-dev"
        ]
      }
      #
      # Public access disbled
      # Allow access from trusted Azure services
      # Allow access from VNet's IP range, test IP address
      public_network_access_enabled = true # Need to be true for Standard SKU
      network_rule_bypass_option    = "AzureServices"
      default_action                = "Deny"
      ip_rule = {
        action = "Allow"
        ip_range = [
          "10.204.70.0/23",
          "88.114.194.49/32"
        ]
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
    }
  }
}
