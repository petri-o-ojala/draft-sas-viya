#
# Terraform providers
#

provider "azurerm" {
  use_oidc            = true
  storage_use_azuread = true

  features {
  }
}
