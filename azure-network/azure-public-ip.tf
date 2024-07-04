#
# Azure Public IPs
#

locals {
  azurerm_public_ip = azurerm_public_ip.lz
}

resource "azurerm_public_ip" "lz" {
  # https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/public_ip
  for_each = {
    for public_ip in local.azure_public_ip : public_ip.resource_index => public_ip
  }

  name                = each.value.name
  resource_group_name = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.resource_group_name : local.azure_resource_group[each.value.resource_group_name].name
  location            = lookup(local.azure_resource_group, each.value.resource_group_name, null) == null ? each.value.location : local.azure_resource_group[each.value.resource_group_name].location
  allocation_method   = each.value.allocation_method
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  zones                   = each.value.zones
  ddos_protection_mode    = each.value.ddos_protection_mode
  ddos_protection_plan_id = each.value.ddos_protection_plan_id
  domain_name_label       = each.value.domain_name_label
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
  ip_tags                 = each.value.ip_tags
  ip_version              = each.value.ip_version
  public_ip_prefix_id     = each.value.public_ip_prefix_id
  reverse_fqdn            = each.value.reverse_fqdn
  sku                     = each.value.sku
  sku_tier                = each.value.sku_tier
}
