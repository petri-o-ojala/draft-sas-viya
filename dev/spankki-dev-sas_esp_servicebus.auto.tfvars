#
# SAS ESP Azure Service Bus
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>
#

#
# This is not enabled by default in viya4-iac-azure
#

/*
sas_esp_servicebus = {
  namespace = {
    "sas-esp-dev" = {
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
      name                         = "sbus-spankki-afc-esp-we-arke-dev"
      resource_group_name          = "rg-spankki-afc-esp-we-servicebus-dev"
      location                     = "westeurope"
      sku                          = "Premium"
      premium_messaging_partitions = 1
      capacity                     = 1
      authorization_rule = {
        name   = "Arke-rule-dev"
        listen = true
        send   = true
        manage = false
      }
    }
  }
}
*/
