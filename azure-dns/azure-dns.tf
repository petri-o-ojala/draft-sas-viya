#
# Azure Public DNS
#

locals {
  azurerm_dns_zone = azurerm_dns_zone.lz
  azurerm_dns_record = merge(
    azurerm_dns_a_record.lz,
    azurerm_dns_aaaa_record.lz,
    azurerm_dns_caa_record.lz,
    azurerm_dns_cname_record.lz,
    azurerm_dns_mx_record.lz,
    azurerm_dns_ns_record.lz,
    azurerm_dns_ptr_record.lz,
    azurerm_dns_srv_record.lz,
    azurerm_dns_txt_record.lz
  )
}

resource "azurerm_dns_zone" "lz" {
  for_each = {
    for zone in local.azure_dns_zone : zone.resource_index => zone
  }

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  dynamic "soa_record" {
    for_each = try(each.value.soa_record, null) == null ? [] : [1]

    content {
      email         = each.value.soa_record.email
      host_name     = each.value.soa_record.host_name
      expire_time   = each.value.soa_record.nexpire_timeame
      minimum_ttl   = each.value.soa_record.minimum_ttl
      refresh_time  = each.value.soa_record.refresh_time
      retry_time    = each.value.soa_record.retry_time
      serial_number = each.value.soa_record.serial_number
      ttl           = each.value.soa_record.ttl
      tags          = each.value.soa_record.tags
    }
  }

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

#
# DNS Records
#

resource "azurerm_dns_a_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "A"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  target_resource_id  = each.value.target_resource_id

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_aaaa_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "AAAA"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records
  target_resource_id  = each.value.target_resource_id

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_caa_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "CAA"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = coalesce(each.value.caa_record, [])

    content {
      flags = record.value.flags
      value = record.value.value
      tag   = record.value.tag
    }
  }

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_cname_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "CNAME"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl
  record              = each.value.cname_record
  target_resource_id  = each.value.target_resource_id

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_mx_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "MX"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = coalesce(each.value.mx_record, [])

    content {
      preference = record.value.preference
      exchange   = record.value.exchange
    }
  }

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_ns_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "NS"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_ptr_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "PTR"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_srv_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "SRV"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = coalesce(each.value.srv_record, [])

    content {
      priority = record.value.priority
      weight   = record.value.weight
      port     = record.value.port
      target   = record.value.target
    }
  }

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_dns_txt_record" "lz" {
  for_each = {
    for record in local.azure_dns_record : record.resource_index => record
    if upper(record.type) == "TXT"
  }

  name                = each.value.name
  zone_name           = lookup(local.azurerm_dns_zone, each.value.zone_name, null) == null ? each.value.zone_name : local.azurerm_dns_zone[each.value.zone_name].name
  resource_group_name = each.value.resource_group_name == null ? local.azurerm_dns_zone[each.value.zone_name].resource_group_name : each.value.resource_group_name
  ttl                 = each.value.ttl

  dynamic "record" {
    for_each = coalesce(each.value.txt_record, [])

    content {
      value = record.value.value
    }
  }

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
