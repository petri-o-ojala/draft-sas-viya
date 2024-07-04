#
# Terraform version constrains
#

terraform {
  required_version = "~> 1.7"

  required_providers {
    azurerm = {
      # Azure Resource Manager
      source  = "hashicorp/azurerm"
      version = "~> 3.110"
    }
    template = {
      # CloudPosse version of template
      source  = "cloudposse/template"
      version = "2.2.0"
    }
  }

  #backend "azurerm" {
    #
    # Backend is stored in Azure Storage Blob, defined in backend.cfg when initialized
    #
  #}
}
