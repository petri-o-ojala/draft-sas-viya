#
# Azure Network Security Groups
#

locals {
  azurerm_network_security_group = azurerm_network_security_group.lz
}

resource "azurerm_network_security_group" "lz" {
  for_each = {
    for nsg in local.azure_network_security_group : nsg.resource_index => nsg
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  dynamic "security_rule" {
    for_each = coalesce(each.value.security_rule, [])

    content {
      description                                = security_rule.value.description
      protocol                                   = security_rule.value.protocol
      source_port_range                          = security_rule.value.source_port_range
      source_port_ranges                         = security_rule.value.source_port_ranges
      destination_port_range                     = security_rule.value.destination_port_range
      destination_port_ranges                    = security_rule.value.destination_port_ranges
      source_address_prefix                      = security_rule.value.source_address_prefix
      source_address_prefixes                    = security_rule.value.source_address_prefixes
      source_application_security_group_ids      = security_rule.value.source_application_security_group_ids
      destination_address_prefix                 = security_rule.value.destination_address_prefix
      destination_address_prefixes               = security_rule.value.destination_address_prefixes
      destination_application_security_group_ids = security_rule.value.destination_application_security_group_ids
      access                                     = security_rule.value.access
      priority                                   = security_rule.value.priority
      direction                                  = security_rule.value.direction
    }
  }

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_network_security_rule" "lz" {
  for_each = {
    for rule in local.azure_network_security_rule : rule.resource_index => rule
  }

  name                        = each.value.name
  resource_group_name         = each.value.resource_group_name
  network_security_group_name = lookup(local.azurerm_network_security_group, each.value.network_security_group_name, null) == null ? each.value.network_security_group_name : local.azurerm_network_security_group[each.value.network_security_group_name].name

  description                                = each.value.description
  protocol                                   = each.value.protocol
  source_port_range                          = each.value.source_port_range
  source_port_ranges                         = each.value.source_port_ranges
  destination_port_range                     = each.value.destination_port_range
  destination_port_ranges                    = each.value.destination_port_ranges
  source_address_prefix                      = each.value.source_address_prefix
  source_address_prefixes                    = each.value.source_address_prefixes
  source_application_security_group_ids      = each.value.source_application_security_group_ids
  destination_address_prefix                 = each.value.destination_address_prefix
  destination_address_prefixes               = each.value.destination_address_prefixes
  destination_application_security_group_ids = each.value.destination_application_security_group_ids
  access                                     = each.value.access
  priority                                   = each.value.priority
  direction                                  = each.value.direction

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
