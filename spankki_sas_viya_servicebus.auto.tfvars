#
# SAS Viya Azure Service Bus
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>
#

sas_viya_servicebus = {
  namespace = {
    "sasa-viya" = {
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
      name                = "sbus-spankki-afc-esp-we-common-dev"
      resource_group_name = "rg-spankki-afc-esp-we-servicebus-dev"
      location            = "westeurope"
      sku                 = "Standard"
      authorization_rule = {
        name   = "sbus-spankki-afc-esp-we-rule-dev"
        listen = true
        send   = true
        manage = false
      }
    }
  }
}
