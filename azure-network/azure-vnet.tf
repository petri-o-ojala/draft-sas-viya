#
# Azure VNet Networking
#

locals {
  azurerm_virtual_network = azurerm_virtual_network.lz
  azurerm_subnet = merge(
    azurerm_subnet.lz,
    local.azure_subnet
  )
}

resource "azurerm_virtual_network" "lz" {
  for_each = {
    for vnet in local.azure_virtual_network : vnet.resource_index => vnet
  }

  name                = each.value.name
  resource_group_name = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location
  address_space       = each.value.address_space
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  bgp_community = each.value.bgp_community
  # dns_servers             = each.value.dns_servers (managed through azurerm_virtual_network_dns_servers)
  edge_zone               = each.value.edge_zone
  flow_timeout_in_minutes = each.value.flow_timeout_in_minutes

  dynamic "ddos_protection_plan" {
    for_each = try(each.value.ddos_protection_plan, null) == null ? [] : [1]

    content {
      id     = each.value.ddos_protection_plan.id
      enable = each.value.ddos_protection_plan.enable
    }
  }

  dynamic "encryption" {
    for_each = try(each.value.encryption, null) == null ? [] : [1]

    content {
      enforcement = each.value.encryption.enforcement
    }
  }

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_role_assignment" "virtual_network" {
  for_each = {
    for assignment in local.azure_virtual_network_role_assignment : assignment.resource_index => assignment
  }

  name         = each.value.name
  principal_id = lookup(local.azure_principal_id, each.value.principal_id, null) == null ? each.value.principal_id : local.azure_principal_id[each.value.principal_id]
  scope        = each.value.scope

  role_definition_id                     = each.value.role_definition_id == null ? null : lookup(local.azure_role_definition, each.value.role_definition_id, null) == null ? each.value.role_definition_id : local.azure_role_definition[each.value.role_definition_id].id
  role_definition_name                   = each.value.role_definition_name
  principal_type                         = each.value.principal_type
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  description                            = each.value.description
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
}

resource "azurerm_virtual_network_dns_servers" "lz" {
  for_each = {
    for vnet in local.azure_virtual_network : vnet.resource_index => vnet
    if vnet.dns_servers != null
  }

  virtual_network_id = azurerm_virtual_network.lz[each.key].id
  dns_servers        = each.value.dns_servers
}

resource "azurerm_subnet" "lz" {
  for_each = {
    for subnet in local.azure_virtual_network_subnet : subnet.resource_index => subnet
  }

  name                 = each.value.name
  resource_group_name  = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = each.value.address_prefixes

  private_endpoint_network_policies             = each.value.private_endpoint_network_policies
  private_link_service_network_policies_enabled = each.value.private_link_service_network_policies_enabled
  service_endpoints                             = each.value.service_endpoints
  service_endpoint_policy_ids                   = each.value.service_endpoint_policy_ids

  dynamic "delegation" {
    for_each = coalesce(each.value.delegation, [])

    content {
      name = delegation.value.name

      service_delegation {
        name    = delegation.value.service_delegation.name
        actions = delegation.value.service_delegation.actions
      }
    }
  }

  depends_on = [
    azurerm_virtual_network.lz
  ]

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_subnet_network_security_group_association" "lz" {
  for_each = {
    for nsg in local.azure_subnet_network_security_group_association : nsg.resource_index => nsg
  }

  subnet_id                 = each.value.subnet_id
  network_security_group_id = lookup(local.azure_network_security_group, each.value.network_security_group_id, null) == null ? each.value.network_security_group_id : local.azure_network_security_group[each.value.network_security_group_id].id
}

resource "azurerm_virtual_network_peering" "lz" {
  for_each = {
    for peering in local.azure_virtual_network_peering : peering.resource_index => peering
  }

  name                      = each.value.name
  virtual_network_name      = each.value.virtual_network_name
  remote_virtual_network_id = each.value.remote_virtual_network_id
  resource_group_name       = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name

  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  allow_gateway_transit        = each.value.allow_gateway_transit
  use_remote_gateways          = each.value.use_remote_gateways
  triggers                     = each.value.triggers
}
