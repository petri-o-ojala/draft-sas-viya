#
# Azure DNS
#

variable "dns" {
  description = "Azure DNS"
  type = object({
    zone = optional(map(object({
      name                = string
      resource_group_name = string
      tags                = optional(map(string))
      soa_record = optional(object({
        email         = string
        host_name     = optional(string)
        expire_time   = optional(number)
        minimum_ttl   = optional(number)
        refresh_time  = optional(number)
        retry_time    = optional(number)
        serial_number = optional(number)
        ttl           = optional(number)
        tags          = optional(map(string))
      }))
    })))
    record = optional(list(object({
      name                = string
      resource_group_name = optional(string)
      zone_name           = string
      type                = string
      ttl                 = number
      target_resource_id  = optional(string)
      tags                = optional(map(string))
      # A, AAAA, NS, PTR type
      records = optional(list(string))
      # CNAME type
      cname_record = optional(string)
      # CAA type
      caa_record = optional(list(object({
        flags = number
        tag   = string
        value = string
      })))
      # MX type
      mx_record = optional(list(object({
        preference = number
        exchange   = string
      })))
      # SRV type
      srv_record = optional(list(object({
        priority = number
        weight   = number
        port     = number
        target   = string
      })))
      # TXT type
      txt_record = optional(list(object({
        value = number
      })))
    })))
    private_zone = optional(map(object({
      name                = string
      resource_group_name = string
      tags                = optional(map(string))
      soa_record = optional(object({
        email         = string
        host_name     = optional(string)
        expire_time   = optional(number)
        minimum_ttl   = optional(number)
        refresh_time  = optional(number)
        retry_time    = optional(number)
        serial_number = optional(number)
        ttl           = optional(number)
        tags          = optional(map(string))
      }))
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
    private_zone_vnet_link = optional(map(object({
      name                  = string
      private_dns_zone_name = string
      resource_group_name   = string
      virtual_network_id    = string
      registration_enabled  = optional(bool)
      tags                  = optional(map(string))
    })))
    private_record = optional(list(object({
      name                = string
      resource_group_name = optional(string)
      zone_name           = string
      type                = string
      ttl                 = number
      target_resource_id  = optional(string)
      tags                = optional(map(string))
      # A, AAAA, NS, PTR type
      records = optional(list(string))
      # CNAME type
      cname_record = optional(string)
      # CAA type
      caa_record = optional(list(object({
        flags = number
        tag   = string
        value = string
      })))
      # MX type
      mx_record = optional(list(object({
        preference = number
        exchange   = string
      })))
      # SRV type
      srv_record = optional(list(object({
        priority = number
        weight   = number
        port     = number
        target   = string
      })))
      # TXT type
      txt_record = optional(list(object({
        value = number
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
  # Azure Public DNS Zones
  #
  azure_dns_zone = flatten([
    for zone_id, zone in coalesce(try(var.dns.zone, null), {}) : merge(
      zone,
      {
        resource_index = join("_", [zone_id])
      }
    )
  ])

  azure_dns_record = flatten([
    for record in coalesce(try(var.dns.record, null), []) : merge(
      record,
      {
        resource_index = join("_", [record.zone_name, record.name, record.type])
      }
    )
  ])

  #
  # Azure Private DNS Zones
  #
  azure_private_dns_zone = flatten([
    for zone_id, zone in coalesce(try(var.dns.private_zone, null), {}) : merge(
      zone,
      {
        resource_index = join("_", [zone_id])
      }
    )
  ])

  azure_private_dns_zone_role_assignment = flatten([
    for zone_id, zone in coalesce(try(var.dns.private_zone, null), {}) : [
      for iam_id, iam in coalesce(zone.iam, []) : [
        for principal in coalesce(try(iam.principal_id, null), []) : merge(
          iam,
          {
            scope          = local.azurerm_private_dns_zone[zone_id].id
            principal_id   = principal
            resource_index = join("_", [zone_id, coalesce(iam.role_definition_name, iam.role_definition_id), principal])
          }
        )
      ]
    ]
    if zone.iam != null
  ])

  azure_private_dns_zone_virtual_network_link = flatten([
    for vnet_id, vnet in coalesce(try(var.dns.private_zone_vnet_link, null), {}) : merge(
      vnet,
      {
        resource_index = join("_", [vnet_id])
      }
    )
  ])

  azure_private_dns_record = flatten([
    for record in coalesce(try(var.dns.private_record, null), []) : merge(
      record,
      {
        resource_index = join("_", [record.zone_name, record.name, record.type])
      }
    )
  ])
}
