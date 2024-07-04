
#
# Azure Database - Managed MS SQL Instance
#

locals {
  azurerm_mssql_managed_instance = azurerm_mssql_managed_instance.lz
}

resource "azurerm_mssql_managed_instance" "lz" {
  for_each = {
    for instance in local.azure_mssql_managed_instance : instance.resource_index => instance
  }

  name                         = each.value.name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  license_type                 = each.value.license_type
  sku_name                     = each.value.sku_name
  administrator_login          = each.value.administrator_login
  administrator_login_password = each.value.administrator_login_password
  vcores                       = each.value.vcores
  storage_size_in_gb           = each.value.storage_size_in_gb
  subnet_id                    = lookup(local.azure_subnet, each.value.subnet_id, null) == null ? each.value.subnet_id : local.azure_subnet[each.value.subnet_id].id

  tags = merge(
    each.value.tags,
    local.common.tags
  )

  collation                      = each.value.collation
  dns_zone_partner_id            = each.value.dns_zone_partner_id
  maintenance_configuration_name = each.value.maintenance_configuration_name
  minimum_tls_version            = each.value.minimum_tls_version
  proxy_override                 = each.value.proxy_override
  public_data_endpoint_enabled   = each.value.public_data_endpoint_enabled
  storage_account_type           = each.value.storage_account_type
  zone_redundant_enabled         = each.value.zone_redundant_enabled
  timezone_id                    = each.value.timezone_id

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }
}
