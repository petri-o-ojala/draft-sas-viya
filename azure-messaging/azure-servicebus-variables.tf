#
# Azure Service Bus
#

variable "servicebus" {
  description = "Azure Service Bus"
  type = object({
    namespace = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
      name                          = string
      resource_group_name           = string
      location                      = string
      tags                          = optional(map(string))
      sku                           = string
      capacity                      = optional(number)
      local_auth_enabled            = optional(bool)
      public_network_access_enabled = optional(bool)
      minimum_tls_version           = optional(string)
      zone_redundant                = optional(bool)
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      customer_managed_key = optional(object({
        key_vault_key_id                  = string
        identity_id                       = string
        infrastructure_encryption_enabled = optional(bool)
      }))
      network_rule_set = optional(object({
        default_action                = optional(string)
        public_network_access_enabled = optional(bool)
        trusted_services_allowed      = optional(bool)
        ip_rules                      = optional(list(string))
        network_rules = optional(list(object({
          subnet_id                            = string
          ignore_missing_vnet_service_endpoint = optional(bool)
        })))
      }))
      authorization_rule = optional(object({
        name   = string
        listen = optional(bool)
        send   = optional(bool)
        manage = optional(bool)
      }))
    })))
  })
  default = {}
}

locals {
  servicebus = var.servicebus

  #
  # Principal IDs
  #
  azure_principal_id = merge(
    local.entra_id_alias,
    {
      for resource_id, principal_id in local.azure_resource_principal_id : resource_id => principal_id
    }
  )

  #
  # Azure Service Bus
  #
  azure_servicebus_namespace = flatten([
    for namespace_id, namespace in coalesce(try(local.servicebus.namespace, null), {}) : merge(
      namespace,
      {
        resource_index = join("_", [namespace_id])
      }
    )
  ])

  azure_servicebus_namespace_authorization_rule = flatten([
    for namespace_id, namespace in coalesce(try(local.servicebus.namespace, null), {}) : merge(
      namespace.authorization_rule,
      {
        namespace_id   = local.azurerm_servicebus_namespace[namespace_id].id
        resource_index = join("_", [namespace_id])
      }
    )
    if namespace.authorization_rule != null
  ])
}
