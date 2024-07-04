#
# Azure Network Gateways
#

locals {
  azurerm_local_network_gateway   = azurerm_local_network_gateway.lz
  azurerm_nat_gateway             = azurerm_nat_gateway.lz
  azurerm_virtual_network_gateway = azurerm_virtual_network_gateway.lz
}

resource "azurerm_local_network_gateway" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/local_network_gateway
  for_each = {
    for gateway in local.azure_local_network_gateway : gateway.resource_index => gateway
  }

  name                = each.value.name
  resource_group_name = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location

  address_space   = each.value.address_space
  gateway_address = each.value.gateway_address
  gateway_fqdn    = each.value.gateway_fqdn
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  dynamic "bgp_settings" {
    # Local Network Gateway's BGP speaker settings
    for_each = try(each.value.bgp_settings, null) == null ? [] : [1]

    content {
      asn                 = each.value.bgp_settings.asn
      bgp_peering_address = each.value.bgp_settings.bgp_peering_address
      peer_weight         = each.value.bgp_settings.peer_weight
    }
  }
}

resource "azurerm_nat_gateway" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/nat_gateway
  for_each = {
    for gateway in local.azure_nat_gateway : gateway.resource_index => gateway
  }

  name                = each.value.name
  resource_group_name = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  sku_name                = each.value.sku_name
  zones                   = each.value.zones
}

resource "azurerm_virtual_network_gateway" "lz" {
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network_gateway
  for_each = {
    for gateway in local.azure_virtual_network_gateway : gateway.resource_index => gateway
  }

  name                = each.value.name
  resource_group_name = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location
  sku                 = each.value.sku
  type                = each.value.type
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  active_active                         = each.value.active_active
  default_local_network_gateway_id      = each.value.default_local_network_gateway_id
  enable_bgp                            = each.value.enable_bgp
  generation                            = each.value.generation
  private_ip_address_enabled            = each.value.private_ip_address_enabled
  bgp_route_translation_for_nat_enabled = each.value.bgp_route_translation_for_nat_enabled
  dns_forwarding_enabled                = each.value.dns_forwarding_enabled
  ip_sec_replay_protection_enabled      = each.value.ip_sec_replay_protection_enabled
  remote_vnet_traffic_enabled           = each.value.remote_vnet_traffic_enabled
  virtual_wan_traffic_enabled           = each.value.virtual_wan_traffic_enabled
  vpn_type                              = each.value.vpn_type

  dynamic "ip_configuration" {
    for_each = coalesce(each.value.ip_configuration, [])

    content {
      name                          = ip_configuration.value.name
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = lookup(local.azurerm_subnet, ip_configuration.value.subnet_id, null) == null ? ip_configuration.value.subnet_id : local.azurerm_subnet[ip_configuration.value.subnet_id].id
      public_ip_address_id          = lookup(local.azurerm_public_ip, ip_configuration.value.public_ip_address_id, null) == null ? ip_configuration.value.public_ip_address_id : local.azurerm_public_ip[ip_configuration.value.public_ip_address_id].id
    }
  }

  dynamic "bgp_settings" {
    for_each = try(each.value.bgp_settings, null) == null ? [] : [1]

    content {
      asn         = each.value.bgp_settings.asn
      peer_weight = each.value.bgp_settings.peer_weight

      dynamic "peering_addresses" {
        for_each = coalesce(each.value.bgp_settings.peering_addresses, [])

        content {
          ip_configuration_name = peering_addresses.value.ip_configuration_name
          apipa_addresses       = peering_addresses.value.apipa_addresses
        }
      }
    }
  }

  dynamic "custom_route" {
    for_each = try(each.value.custom_route, null) == null ? [] : [1]

    content {
      address_prefixes = each.value.custom_route.address_prefixes
    }
  }

  dynamic "policy_group" {
    for_each = coalesce(each.value.policy_group, [])

    content {
      name       = policy_group.value.name
      is_default = policy_group.value.is_default
      priority   = policy_group.value.priority

      dynamic "policy_member" {
        for_each = coalesce(policy_group.value.policy_member, [])

        content {
          name  = policy_member.value.name
          type  = policy_member.value.type
          value = policy_member.value.value
        }
      }
    }
  }

  dynamic "vpn_client_configuration" {
    for_each = try(each.value.vpn_client_configuration, null) == null ? [] : [1]

    content {
      address_space         = each.value.vpn_client_configuration.address_space
      aad_tenant            = each.value.vpn_client_configuration.aad_tenant
      aad_audience          = each.value.vpn_client_configuration.aad_audience
      aad_issuer            = each.value.vpn_client_configuration.aad_issuer
      radius_server_address = each.value.vpn_client_configuration.radius_server_address
      radius_server_secret  = each.value.vpn_client_configuration.radius_server_secret
      vpn_client_protocols  = each.value.vpn_client_configuration.vpn_client_protocols
      vpn_auth_types        = each.value.vpn_client_configuration.vpn_auth_types

      dynamic "ipsec_policy" {
        for_each = try(each.value.vpn_client_configuration.ipsec_policy, null) == null ? [] : [1]

        content {
          dh_group                  = each.value.vpn_client_configuration.ipsec_policy.dh_group
          ike_encryption            = each.value.vpn_client_configuration.ipsec_policy.ike_encryption
          ike_integrity             = each.value.vpn_client_configuration.ipsec_policy.ike_integrity
          ipsec_encryption          = each.value.vpn_client_configuration.ipsec_policy.ipsec_encryption
          ipsec_integrity           = each.value.vpn_client_configuration.ipsec_policy.ipsec_integrity
          pfs_group                 = each.value.vpn_client_configuration.ipsec_policy.pfs_group
          sa_lifetime_in_seconds    = each.value.vpn_client_configuration.ipsec_policy.sa_lifetime_in_seconds
          sa_data_size_in_kilobytes = each.value.vpn_client_configuration.ipsec_policy.sa_data_size_in_kilobytes
        }
      }

      dynamic "root_certificate" {
        for_each = coalesce(each.value.vpn_client_configuration.root_certificate, [])

        content {
          name             = root_certificate.value.name
          public_cert_data = root_certificate.value.public_cert_data
        }
      }

      dynamic "revoked_certificate" {
        for_each = coalesce(each.value.vpn_client_configuration.revoked_certificate, [])

        content {
          name       = revoked_certificate.value.name
          thumbprint = revoked_certificate.value.thumbprint
        }
      }

      dynamic "radius_server" {
        for_each = coalesce(each.value.vpn_client_configuration.radius_server, [])

        content {
          address = radius_server.value.address
          secret  = radius_server.value.secret
          score   = radius_server.value.score
        }
      }

      dynamic "virtual_network_gateway_client_connection" {
        for_each = coalesce(each.value.vpn_client_configuration.virtual_network_gateway_client_connection, [])

        content {
          name               = virtual_network_gateway_client_connection.value.name
          policy_group_names = virtual_network_gateway_client_connection.value.policy_group_names
          address_prefixes   = virtual_network_gateway_client_connection.value.address_prefixes
        }
      }
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "virtual_network_gateway" {
  for_each = {
    for gateway in local.azure_virtual_network_gateway : gateway.resource_index => gateway
    if gateway.diagnostic_setting != null
  }

  name                           = each.value.name
  target_resource_id             = local.azurerm_virtual_network_gateway[each.key].id
  eventhub_name                  = each.value.diagnostic_setting.eventhub_name
  eventhub_authorization_rule_id = each.value.diagnostic_setting.eventhub_authorization_rule_id
  log_analytics_workspace_id     = each.value.diagnostic_setting.log_analytics_workspace_id == null ? null : lookup(local.azure_log_analytics_workspace, each.value.diagnostic_setting.log_analytics_workspace_id, null) == null ? each.value.diagnostic_setting.log_analytics_workspace_id : local.azure_log_analytics_workspace[each.value.diagnostic_setting.log_analytics_workspace_id].id
  storage_account_id             = each.value.diagnostic_setting.storage_account_id == null ? null : lookup(local.azure_storage_account, each.value.diagnostic_setting.storage_account_id, null) == null ? each.value.diagnostic_setting.storage_account_id : local.azure_storage_account[each.value.diagnostic_setting.storage_account_id].id
  log_analytics_destination_type = each.value.diagnostic_setting.log_analytics_destination_type
  partner_solution_id            = each.value.diagnostic_setting.partner_solution_id

  dynamic "enabled_log" {
    for_each = coalesce(each.value.diagnostic_setting.enabled_log, [])

    content {
      category       = enabled_log.value.category
      category_group = enabled_log.value.category_group
    }
  }

  dynamic "metric" {
    for_each = coalesce(each.value.diagnostic_setting.metric, [])

    content {
      category = metric.value.category
      enabled  = metric.value.enabled
    }
  }
}
