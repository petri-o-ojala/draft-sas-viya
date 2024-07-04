#
# Azure Private Endpoints
#

resource "azurerm_private_endpoint" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
  for_each = {
    for endpoint in local.azure_private_endpoint : endpoint.resource_index => endpoint
  }

  name                = each.value.name
  resource_group_name = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location
  subnet_id           = lookup(local.azurerm_subnet, each.value.subnet_id, null) == null ? each.value.subnet_id : local.azurerm_subnet[each.value.subnet_id].id
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  custom_network_interface_name = each.value.custom_network_interface_name

  dynamic "private_dns_zone_group" {
    for_each = try(each.value.private_dns_zone_group, null) == null ? [] : [1]

    content {
      name = each.value.private_dns_zone_group.name
      private_dns_zone_ids = [
        for id in each.value.private_dns_zone_group.private_dns_zone_ids : lookup(local.azure_private_dns_zone, id) == null ? id : local.azure_private_dns_zone[id].id
      ]
    }
  }

  dynamic "private_service_connection" {
    for_each = try(each.value.private_service_connection, null) == null ? [] : [1]

    content {
      name                              = each.value.private_service_connection.name
      is_manual_connection              = each.value.private_service_connection.is_manual_connection
      private_connection_resource_id    = each.value.private_service_connection.private_connection_resource_id
      private_connection_resource_alias = each.value.private_service_connection.private_connection_resource_alias
      subresource_names                 = each.value.private_service_connection.subresource_names
      request_message                   = each.value.private_service_connection.request_message
    }
  }

  dynamic "ip_configuration" {
    for_each = coalesce(each.value.ip_configuration, [])

    content {
      name               = ip_configuration.value.name
      private_ip_address = ip_configuration.value.private_ip_address
      subresource_name   = ip_configuration.value.subresource_name
      member_name        = ip_configuration.value.member_name
    }
  }

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
