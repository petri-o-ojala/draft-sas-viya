#
# Azure Network Interfaces
#

locals {
  azurerm_network_interface = azurerm_network_interface.lz
}

resource "azurerm_network_interface" "lz" {
  for_each = {
    for interface in local.azure_network_interface : interface.resource_index => interface
  }

  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  auxiliary_mode                = each.value.auxiliary_mode
  auxiliary_sku                 = each.value.auxiliary_sku
  dns_servers                   = each.value.dns_servers
  enable_ip_forwarding          = each.value.enable_ip_forwarding
  enable_accelerated_networking = each.value.enable_accelerated_networking
  internal_dns_name_label       = each.value.internal_dns_name_label

  dynamic "ip_configuration" {
    for_each = coalesce(each.value.ip_configuration, [])

    content {
      name                                               = ip_configuration.value.name
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id
      subnet_id                                          = lookup(local.azure_subnet, ip_configuration.value.subnet_id, null) == null ? ip_configuration.value.subnet_id : local.azure_subnet[ip_configuration.value.subnet_id].id
      private_ip_address_version                         = ip_configuration.value.private_ip_address_version
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id                               = ip_configuration.value.public_ip_address_id == null ? null : lookup(local.azurerm_public_ip, ip_configuration.value.public_ip_address_id, null) == null ? ip_configuration.value.public_ip_address_id : local.azurerm_public_ip[ip_configuration.value.public_ip_address_id].id
      primary                                            = ip_configuration.value.primary
      private_ip_address                                 = ip_configuration.value.private_ip_address
    }
  }

  tags = each.value.tags
}
