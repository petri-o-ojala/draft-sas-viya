#
# Azure Service Bus
#

locals {
  azurerm_servicebus_namespace = azurerm_servicebus_namespace.lz
}

resource "azurerm_servicebus_namespace" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace
  for_each = {
    for namespace in local.azure_servicebus_namespace : namespace.resource_index => namespace
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  sku                           = each.value.sku
  capacity                      = each.value.capacity
  premium_messaging_partitions  = each.value.premium_messaging_partitions
  local_auth_enabled            = each.value.local_auth_enabled
  public_network_access_enabled = each.value.public_network_access_enabled
  minimum_tls_version           = each.value.minimum_tls_version
  zone_redundant                = each.value.zone_redundant

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(each.value.customer_managed_key, null) == null ? [] : [1]

    content {
      key_vault_key_id                  = each.value.customer_managed_key.key_vault_key_id
      identity_id                       = each.value.customer_managed_key.identity_id
      infrastructure_encryption_enabled = each.value.customer_managed_key.infrastructure_encryption_enabled
    }
  }

  dynamic "network_rule_set" {
    for_each = try(each.value.network_rule_set, null) == null ? [] : [1]

    content {
      default_action                = each.value.network_rule_set.default_action
      public_network_access_enabled = each.value.network_rule_set.public_network_access_enabled
      trusted_services_allowed      = each.value.network_rule_set.trusted_services_allowed
      ip_rules                      = each.value.network_rule_set.ip_rules

      dynamic "network_rules" {
        for_each = coalesce(each.value.network_rule_set.network_rules, [])

        content {
          subnet_id                            = network_rules.value.subnet_id
          ignore_missing_vnet_service_endpoint = network_rules.value.ignore_missing_vnet_service_endpoint
        }
      }
    }
  }
}

resource "azurerm_servicebus_namespace_authorization_rule" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/servicebus_namespace_authorization_rule
  for_each = {
    for namespace in local.azure_servicebus_namespace_authorization_rule : namespace.resource_index => namespace
  }

  name         = each.value.name
  namespace_id = each.value.namespace_id

  listen = each.value.listen
  send   = each.value.send
  manage = each.value.manage
}
