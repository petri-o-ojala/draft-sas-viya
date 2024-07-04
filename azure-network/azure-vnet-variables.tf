#
# Azure VNet Networking
#

variable "network" {
  description = "Azure VNet Networking"
  type = object({
    private_endpoint = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
      name                          = string
      custom_metadata               = optional(map(string))
      resource_group_name           = string
      location                      = optional(string)
      tags                          = optional(map(string))
      subnet_id                     = string
      custom_network_interface_name = optional(string)
      private_dns_zone_group = optional(object({
        name                 = string
        private_dns_zone_ids = list(string)
      }))
      private_service_connection = optional(object({
        name                              = string
        is_manual_connection              = bool
        private_connection_resource_id    = optional(string)
        private_connection_resource_alias = optional(string)
        subresource_names                 = optional(list(string))
        request_message                   = optional(string)
      }))
      ip_configuration = optional(list(object({
        name               = string
        private_ip_address = string
        subresource_name   = optional(string)
        member_name        = optional(string)
      })))
    })))
    public_ip = optional(map(object({
      name                    = string
      custom_metadata         = optional(map(string))
      resource_group_name     = string
      location                = optional(string)
      tags                    = optional(map(string))
      allocation_method       = string
      zones                   = optional(list(string))
      ddos_protection_mode    = optional(string)
      ddos_protection_plan_id = optional(string)
      domain_name_label       = optional(string)
      idle_timeout_in_minutes = optional(number)
      ip_tags                 = optional(map(string))
      ip_version              = optional(string)
      public_ip_prefix_id     = optional(string)
      reverse_fqdn            = optional(string)
      sku                     = optional(string)
      sku_tier                = optional(string)
    })))
    virtual_network_gateway = optional(map(object({
      name                                  = string
      custom_metadata                       = optional(map(string))
      resource_group_name                   = string
      location                              = optional(string)
      tags                                  = optional(map(string))
      sku                                   = string
      type                                  = string
      active_active                         = optional(bool)
      default_local_network_gateway_id      = optional(string)
      enable_bgp                            = optional(bool)
      generation                            = optional(string)
      private_ip_address_enabled            = optional(bool)
      bgp_route_translation_for_nat_enabled = optional(bool)
      dns_forwarding_enabled                = optional(bool)
      ip_sec_replay_protection_enabled      = optional(bool)
      remote_vnet_traffic_enabled           = optional(bool)
      virtual_wan_traffic_enabled           = optional(bool)
      vpn_type                              = optional(string)
      ip_configuration = list(object({
        name                          = optional(string)
        private_ip_address_allocation = optional(string)
        subnet_id                     = string
        public_ip_address_id          = string
      }))
      bgp_settings = optional(object({
        asn         = optional(string)
        peer_weight = optional(number)
        peering_addresses = optional(list(object({
          ip_configuration_name = optional(string)
          apipa_addresses       = optional(list(string))
        })))
      }))
      custom_route = optional(object({
        address_prefixes = optional(list(string))
      }))
      policy_group = optional(list(object({
        name       = string
        is_default = optional(bool)
        priority   = optional(number)
        policy_member = list(object({
          name  = string
          type  = string
          value = string
        }))
      })))
      vpn_client_configuration = optional(object({
        address_space         = list(string)
        aad_tenant            = optional(string)
        aad_audience          = optional(string)
        aad_issuer            = optional(string)
        radius_server_address = optional(string)
        radius_server_secret  = optional(string)
        vpn_client_protocols  = optional(list(string))
        vpn_auth_types        = optional(list(string))
        ipsec_policy = optional(object({
          dh_group                  = string
          ike_encryption            = string
          ike_integrity             = string
          ipsec_encryption          = string
          ipsec_integrity           = string
          pfs_group                 = string
          sa_lifetime_in_seconds    = number
          sa_data_size_in_kilobytes = number
        }))
        root_certificate = optional(list(object({
          name             = string
          public_cert_data = string
        })))
        revoked_certificate = optional(list(object({
          name       = string
          thumbprint = string
        })))
        radius_server = optional(list(object({
          address = string
          secret  = string
          score   = number
        })))
        virtual_network_gateway_client_connection = optional(list(object({
          name               = string
          policy_group_names = list(string)
          address_prefixes   = list(string)
        })))
      }))
      diagnostic_setting = optional(object({
        name                           = optional(string)
        custom_metadata                = optional(map(string))
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
        log_analytics_workspace_id     = optional(string)
        storage_account_id             = optional(string)
        log_analytics_destination_type = optional(string)
        partner_solution_id            = optional(string)
        enabled_log = optional(list(object({
          category       = optional(string)
          category_group = optional(string)
          retention_policy = optional(object({
            days    = optional(number)
            enabled = optional(bool)
          }))
        })))
        metric = optional(list(object({
          category = string
          enabled  = optional(bool)
          retention_policy = optional(object({
            days    = optional(number)
            enabled = optional(bool)
          }))
        })))
      }))
    })))
    nat_gateway = optional(map(object({
      name                    = string
      custom_metadata         = optional(map(string))
      resource_group_name     = string
      location                = optional(string)
      tags                    = optional(map(string))
      idle_timeout_in_minutes = optional(number)
      sku_name                = optional(string)
      zones                   = optional(list(string))
    })))
    local_network_gateway = optional(map(object({
      name                = string
      custom_metadata     = optional(map(string))
      resource_group_name = string
      location            = optional(string)
      address_space       = optional(string)
      gateway_address     = optional(string)
      gateway_fqdn        = optional(string)
      tags                = optional(map(string))
      bgp_settings = optional(object({
        asn                 = number
        bgp_peering_address = string
        peer_weight         = optional(number)
      }))
    })))
    vnet = optional(map(object({
      name                    = string
      custom_metadata         = optional(map(string))
      resource_group_name     = string
      location                = optional(string)
      address_space           = list(string)
      tags                    = optional(map(string))
      bgp_community           = optional(string)
      edge_zone               = optional(string)
      dns_servers             = optional(list(string))
      flow_timeout_in_minutes = optional(number)
      ddos_protection_plan = optional(object({
        id     = string
        enable = bool
      }))
      encryption = optional(object({
        enforcement = string
      }))
      subnet = optional(map(object({
        name                 = optional(string)
        custom_metadata      = optional(map(string))
        resource_group_name  = optional(string)
        virtual_network_name = optional(string)
        address_prefixes     = list(string)
        delegation = optional(list(object({
          name = string
          service_delegation = object({
            name    = string
            actions = optional(list(string))
          })
        })))
        private_endpoint_network_policies             = optional(bool)
        private_link_service_network_policies_enabled = optional(bool)
        service_endpoints                             = optional(list(string))
        service_endpoint_policy_ids                   = optional(list(string))
        network_security_group                        = optional(list(string))
      })))
      peering = optional(map(object({
        name                         = string
        custom_metadata              = optional(map(string))
        virtual_network_name         = optional(string)
        remote_virtual_network_id    = optional(string)
        resource_group_name          = optional(string)
        allow_virtual_network_access = optional(bool)
        allow_forwarded_traffic      = optional(bool)
        allow_gateway_transit        = optional(bool)
        use_remote_gateways          = optional(bool)
        triggers                     = optional(map(string))
      })))
      iam = optional(list(object({
        name                                   = optional(string)
        role_definition_name                   = optional(string)
        role_definition_id                     = optional(string)
        principal_type                         = optional(string)
        scope                                  = optional(string)
        principal_id                           = list(string)
        condition                              = optional(string)
        condition_version                      = optional(string)
        delegated_managed_identity_resource_id = optional(string)
        description                            = optional(string)
        skip_service_principal_aad_check       = optional(bool)
      })))
    })))
  })
  default = {}
}

locals {
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
  # Azure VNet networks
  #
  azure_virtual_network = flatten([
    for vnet_id, vnet in coalesce(try(var.network.vnet, null), {}) : merge(
      vnet,
      {
        name = templatestring(vnet.name, merge(
          local.common.custom_metadata,
          vnet.custom_metadata
        ))
        resource_group_name = templatestring(vnet.resource_group_name, merge(
          local.common.custom_metadata,
          vnet.custom_metadata
        ))
        resource_index = join("_", [vnet_id])
      }
    )
  ])

  azure_virtual_network_role_assignment = flatten([
    for vnet_id, vnet in coalesce(try(var.network.vnet, null), {}) : [
      for iam_id, iam in coalesce(vnet.iam, []) : [
        for principal in coalesce(try(iam.principal_id, null), []) : merge(
          iam,
          {
            scope          = local.azurerm_virtual_network[vnet_id].id
            principal_id   = principal
            resource_index = join("_", [vnet_id, coalesce(iam.role_definition_name, iam.role_definition_id), principal])
          }
        )
      ]
    ]
    if vnet.iam != null
  ])

  #
  # Azure Vnet Subnets
  #
  azure_virtual_network_subnet = flatten([
    for vnet_id, vnet in coalesce(try(var.network.vnet, null), {}) : [
      for subnet_id, subnet in coalesce(try(vnet.subnet, null), {}) : merge(
        subnet,
        {
          name = subnet.name == null ? subnet_id : coalesce(templatestring(subnet.name, merge(
            local.common.custom_metadata,
            vnet.custom_metadata,
            subnet.custom_metadata
          )))
          resource_group_name = subnet.resource_group_name != null ? subnet.resource_group_name : templatestring(vnet.resource_group_name, merge(
            local.common.custom_metadata,
            vnet.custom_metadata,
            subnet.custom_metadata
          ))
          virtual_network_name = coalesce(subnet.virtual_network_name, vnet.name)
          resource_index       = join("_", [vnet_id, subnet_id])
        }
      )
    ]
  ])

  #
  # Azure VNet Peerings
  #
  azure_virtual_network_peering = flatten([
    for vnet_id, vnet in coalesce(try(var.network.vnet, null), {}) : [
      for peering_id, peering in coalesce(vnet.peering, {}) : merge(
        peering,
        {
          name = templatestring(peering.name, merge(
            local.common.custom_metadata,
            peering.custom_metadata
          ))
          virtual_network_name      = peering.virtual_network_name != null ? peering.virtual_network_name : local.azurerm_virtual_network[vnet_id].name
          remote_virtual_network_id = peering.remote_virtual_network_id != null ? peering.remote_virtual_network_id : local.azurerm_virtual_network[vnet_id].id
          resource_group_name       = peering.resource_group_name != null ? peering.resource_group_name : local.azurerm_virtual_network[vnet_id].resource_group_name
          resource_index            = join("_", [vnet_id, peering_id])
        }
      )
    ]
  ])

  #
  # Azure Network Security Group Associations
  #
  azure_subnet_network_security_group_association = flatten([
    for vnet_id, vnet in coalesce(try(var.network.vnet, null), {}) : [
      for subnet_id, subnet in coalesce(try(vnet.subnet, null), {}) : [
        for nsg in coalesce(subnet.network_security_group, []) : merge(
          {
            subnet_id                 = local.azurerm_subnet[join("_", [vnet_id, subnet_id])].id
            network_security_group_id = nsg
            resource_index            = join("_", [vnet_id, subnet_id, nsg])
          }
        )
      ]
    ]
  ])

  #
  # Local Network Gateways
  #
  azure_local_network_gateway = flatten([
    for gateway_id, gateway in coalesce(try(var.network.local_network_gateway, null), {}) : merge(
      gateway,
      {
        name = templatestring(gateway.name, merge(
          local.common.custom_metadata,
          gateway.custom_metadata
        ))
        resource_group_name = templatestring(gateway.resource_group_name, merge(
          local.common.custom_metadata,
          gateway.custom_metadata
        ))
        resource_index = join("_", [gateway_id])
      }
    )
  ])

  #
  # Azure NAT Gateways
  #
  azure_nat_gateway = flatten([
    for gateway_id, gateway in coalesce(try(var.network.nat_gateway, null), {}) : merge(
      gateway,
      {
        name = templatestring(gateway.name, merge(
          local.common.custom_metadata,
          gateway.custom_metadata
        ))
        resource_group_name = templatestring(gateway.resource_group_name, merge(
          local.common.custom_metadata,
          gateway.custom_metadata
        ))
        resource_index = join("_", [gateway_id])
      }
    )
  ])

  #
  # Azure Virtual Network Gateways
  #
  azure_virtual_network_gateway = flatten([
    for gateway_id, gateway in coalesce(try(var.network.virtual_network_gateway, null), {}) : merge(
      gateway,
      {
        name = templatestring(gateway.name, merge(
          local.common.custom_metadata,
          gateway.custom_metadata
        ))
        resource_group_name = templatestring(gateway.resource_group_name, merge(
          local.common.custom_metadata,
          gateway.custom_metadata
        ))
        resource_index = join("_", [gateway_id])
      }
    )
  ])

  #
  # Azure Public IPs
  #
  azure_public_ip = flatten([
    for ip_id, ip in coalesce(try(var.network.public_ip, null), {}) : merge(
      ip,
      {
        name = templatestring(ip.name, merge(
          local.common.custom_metadata,
          ip.custom_metadata
        ))
        resource_group_name = templatestring(ip.resource_group_name, merge(
          local.common.custom_metadata,
          ip.custom_metadata
        ))
        resource_index = join("_", [ip_id])
      }
    )
  ])

  #
  # Azure Private Endpoints
  #
  azure_private_endpoint = flatten([
    for endpoint_id, endpoint in coalesce(try(var.network.private_endpoint, null), {}) : merge(
      endpoint,
      {
        name = templatestring(endpoint.name, merge(
          local.common.custom_metadata,
          endpoint.custom_metadata
        ))
        resource_group_name = templatestring(endpoint.resource_group_name, merge(
          local.common.custom_metadata,
          endpoint.custom_metadata
        ))
        resource_index = join("_", [endpoint_id])
      }
    )
  ])
}
