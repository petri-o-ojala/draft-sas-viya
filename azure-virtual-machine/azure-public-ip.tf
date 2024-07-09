#
# Azure Public IPs
#

locals {
  azurerm_public_ip = azurerm_public_ip.lz
}

resource "azurerm_public_ip" "lz" {
  for_each = {
    for ip in local.azure_public_ip : ip.resource_index => ip
  }

  name                    = each.value.name
  resource_group_name     = each.value.resource_group_name
  location                = each.value.location
  allocation_method       = each.value.allocation_method
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
  tags                    = each.value.tags
}
