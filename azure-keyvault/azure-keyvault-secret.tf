#
# Azure Keyvault Secrets
#

resource "random_password" "lz" {
  for_each = {
    for value in local.azure_key_vault_secret_value : value.resource_index => value
  }

  ## Need to match the password policy
  length           = each.value.random_password.length
  upper            = each.value.random_password.upper
  min_upper        = each.value.random_password.min_upper
  lower            = each.value.random_password.lower
  min_lower        = each.value.random_password.min_lower
  numeric          = each.value.random_password.numeric
  min_numeric      = each.value.random_password.min_numeric
  special          = each.value.random_password.special
  override_special = each.value.random_password.override_special
  min_special      = each.value.random_password.min_special

  lifecycle {
    # To avoid replacement e.g. with import
    ignore_changes = [
      length,
      min_lower,
      min_numeric,
      min_special,
      min_upper,
      override_special
    ]
  }
}

resource "azurerm_key_vault_secret" "lz" {
  for_each = {
    for secret in local.azure_key_vault_secret : secret.resource_index => secret
  }

  name         = each.value.name
  value        = each.value.random_password != null ? random_password.lz[each.key].result : each.value.value
  key_vault_id = lookup(local.azurerm_key_vault, each.value.key_vault_id, null) == null ? each.value.key_vault_id : local.azurerm_key_vault[each.value.key_vault_id].id
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  content_type    = each.value.content_type
  not_before_date = each.value.not_before_date
  expiration_date = each.value.expiration_date
}
