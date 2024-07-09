#
# Azure Storage Accounts
#

locals {
  azurerm_storage_account = azurerm_storage_account.lz
}

resource "azurerm_storage_account" "lz" {
  for_each = {
    for account in local.azure_storage_account : account.resource_index => account
  }

  lifecycle {
    ignore_changes = [
      customer_managed_key # requires user_assigned_identity_id that is not used
    ]
  }

  name                     = each.value.name
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_kind             = each.value.account_kind
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  cross_tenant_replication_enabled = each.value.cross_tenant_replication_enabled
  access_tier                      = each.value.access_tier
  enable_https_traffic_only        = each.value.enable_https_traffic_only
  min_tls_version                  = each.value.min_tls_version
  shared_access_key_enabled        = each.value.shared_access_key_enabled
  public_network_access_enabled    = each.value.public_network_access_enabled
  default_to_oauth_authentication  = each.value.default_to_oauth_authentication
  is_hns_enabled                   = each.value.is_hns_enabled
  nfsv3_enabled                    = each.value.nfsv3_enabled
  large_file_share_enabled         = each.value.large_file_share_enabled
  #local_user_enabled                = each.value.local_user_enabled
  queue_encryption_key_type         = each.value.queue_encryption_key_type
  table_encryption_key_type         = each.value.table_encryption_key_type
  infrastructure_encryption_enabled = each.value.infrastructure_encryption_enabled
  allowed_copy_scope                = each.value.allowed_copy_scope
  sftp_enabled                      = each.value.sftp_enabled
  allow_nested_items_to_be_public   = each.value.allow_nested_items_to_be_public
  # dns_endpoint_type                 = each.value.dns_endpoint_type
  tags = merge(
    each.value.tags,
    local.common.tags
  )

  dynamic "identity" {
    for_each = try(each.value.identity, null) == null ? [] : [1]

    content {
      type         = each.value.identity.type
      identity_ids = each.value.identity.identity_ids
    }
  }

  dynamic "custom_domain" {
    for_each = try(each.value.custom_domain, null) == null ? [] : [1]

    content {
      name          = each.value.custom_domain.name
      use_subdomain = each.value.custom_domain.use_subdomain
    }
  }

  dynamic "customer_managed_key" {
    for_each = try(each.value.customer_managed_key, null) == null ? [] : [1]

    content {
      key_vault_key_id          = each.value.customer_managed_key.key_vault_key_id
      user_assigned_identity_id = each.value.customer_managed_key.user_assigned_identity_id
    }
  }

  dynamic "blob_properties" {
    for_each = try(each.value.blob_properties, null) == null ? [] : [1]

    content {
      versioning_enabled            = each.value.blob_properties.versioning_enabled
      change_feed_enabled           = each.value.blob_properties.change_feed_enabled
      change_feed_retention_in_days = each.value.blob_properties.change_feed_retention_in_days
      default_service_version       = each.value.blob_properties.default_service_version
      last_access_time_enabled      = each.value.blob_properties.last_access_time_enabled

      dynamic "cors_rule" {
        for_each = try(each.value.blob_properties.cors_rule, null) == null ? [] : [1]

        content {
          allowed_headers    = each.value.blob_properties.cors_rule.allowed_headers
          allowed_methods    = each.value.blob_properties.cors_rule.allowed_methods
          allowed_origins    = each.value.blob_properties.cors_rule.allowed_origins
          exposed_headers    = each.value.blob_properties.cors_rule.exposed_headers
          max_age_in_seconds = each.value.blob_properties.cors_rule.max_age_in_seconds
        }
      }

      dynamic "delete_retention_policy" {
        for_each = try(each.value.blob_properties.delete_retention_policy, null) == null ? [] : [1]


        content {
          days = each.value.blob_properties.delete_retention_policy.days
        }
      }

      dynamic "restore_policy" {
        for_each = try(each.value.blob_properties.restore_policy, null) == null ? [] : [1]


        content {
          days = each.value.blob_properties.restore_policy.days
        }
      }

      dynamic "container_delete_retention_policy" {
        for_each = try(each.value.blob_properties.container_delete_retention_policy, null) == null ? [] : [1]


        content {
          days = each.value.blob_properties.container_delete_retention_policy.days
        }
      }
    }
  }

  /*
dynamic "queue_properties" {
    for_each = try(each.value.queue_properties, null) == null ? [] : [1]

  content {
  }
}

dynamic "static_website" {
    for_each = try(each.value.static_website, null) == null ? [] : [1]

  content {
  }
}

dynamic "share_properties" {
    for_each = try(each.value.share_properties, null) == null ? [] : [1]

  content {
  }
}
*/

  dynamic "network_rules" {
    for_each = try(each.value.network_rules, null) == null ? [] : [1]

    content {
      default_action = each.value.network_rules.default_action
      bypass         = each.value.network_rules.bypass
      ip_rules       = each.value.network_rules.ip_rules
      virtual_network_subnet_ids = each.value.network_rules.virtual_network_subnet_ids == null ? null : [
        for id in each.value.network_rules.virtual_network_subnet_ids : lookup(local.azure_subnet, id, null) == null ? id : local.azure_subnet[id].id
      ]

      dynamic "private_link_access" {
        for_each = coalesce(each.value.network_rules.private_link_access, [])


        content {
          endpoint_resource_id = lookup(local.azure_resource_id, private_link_access.value.endpoint_resource_id, null) == null ? private_link_access.value.endpoint_resource_id : local.azure_resource_id[private_link_access.value.endpoint_resource_id].id
          endpoint_tenant_id   = private_link_access.value.endpoint_tenant_id
        }
      }
    }
  }

  /*
dynamic "azure_files_authentication" {
    for_each = try(each.value.azure_files_authentication, null) == null ? [] : [1]

  content {
  }
}

dynamic "routing" {
    for_each = try(each.value.routing, null) == null ? [] : [1]

  content {
  }
}

dynamic "immutability_policy" {
    for_each = try(each.value.immutability_policy, null) == null ? [] : [1]

  content {
  }
}

dynamic "sas_policy" {
    for_each = try(each.value.sas_policy, null) == null ? [] : [1]

  content {
  }
}

dynamic "routing" {
    for_each = try(each.value.routing, null) == null ? [] : [1]

  content {
  }
}
*/

  timeouts {
    # Default for all resources
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}

resource "azurerm_management_lock" "storage_account" {
  for_each = {
    for account in local.azure_storage_account : account.resource_index => account
    if account.management_lock != null
  }

  name       = coalesce(each.value.management_lock.name, each.value.name)
  scope      = local.azurerm_storage_account[each.key].id
  lock_level = each.value.management_lock.lock_level
  notes      = each.value.valueoup.management_lock.notes
}


resource "azurerm_monitor_diagnostic_setting" "storage_account" {
  for_each = {
    for account in local.azure_storage_account_diagnostic_setting : account.resource_index => account
  }

  name                           = coalesce(each.value.diagnostic_setting.name, each.value.name)
  target_resource_id             = "${local.azurerm_storage_account[each.value.storage_account_resource_index].id}${each.value.target_resource_id_suffix}"
  eventhub_name                  = each.value.diagnostic_setting.eventhub_name
  eventhub_authorization_rule_id = each.value.diagnostic_setting.eventhub_authorization_rule_id
  log_analytics_workspace_id     = each.value.diagnostic_setting.log_analytics_workspace_id == null ? null : lookup(local.azure_log_analytics_workspace, each.value.diagnostic_setting.log_analytics_workspace_id, null) == null ? each.value.diagnostic_setting.log_analytics_workspace_id : local.azure_log_analytics_workspace[each.value.diagnostic_setting.log_analytics_workspace_id].id
  storage_account_id             = each.value.diagnostic_setting.storage_account_id == null ? null : lookup(azurerm_storage_account.lz, each.value.diagnostic_setting.storage_account_id, null) == null ? each.value.diagnostic_setting.storage_account_id : azurerm_storage_account.lz[each.value.diagnostic_setting.storage_account_id].id
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

resource "azurerm_private_endpoint" "storage_account" {
  for_each = {
    for account in local.azure_storage_account_private_endpoint : account.resource_index => account
  }

  name                = each.value.private_endpoint.name
  resource_group_name = each.value.private_endpoint.resource_group_name
  location            = each.value.private_endpoint.location
  subnet_id           = lookup(local.azure_subnet, each.value.private_endpoint.subnet_id, null) == null ? each.value.private_endpoint.subnet_id : local.azure_subnet[each.value.private_endpoint.subnet_id].id

  custom_network_interface_name = each.value.private_endpoint.custom_network_interface_name
  tags = merge(
    each.value.private_endpoint.tags,
    local.common.tags
  )

  dynamic "private_dns_zone_group" {
    for_each = try(each.value.private_endpoint.private_dns_zone_group, null) == null ? [] : [1]

    content {
      name = each.value.private_endpoint.private_dns_zone_group.name
      private_dns_zone_ids = each.value.private_endpoint.private_dns_zone_group.private_dns_zone_ids == null ? null : [
        for id in each.value.private_endpoint.private_dns_zone_group.private_dns_zone_ids : lookup(local.azure_private_dns_zone, id, null) == null ? id : local.azure_private_dns_zone[id].id
      ]
    }
  }

  dynamic "private_service_connection" {
    for_each = try(each.value.private_endpoint.private_service_connection, null) == null ? [] : [1]

    content {
      name                              = each.value.private_endpoint.private_service_connection.name
      is_manual_connection              = each.value.private_endpoint.private_service_connection.is_manual_connection
      private_connection_resource_id    = coalesce(each.value.private_endpoint.private_service_connection.private_connection_resource_id, local.azurerm_storage_account[each.value.storage_account_resource_index].id)
      private_connection_resource_alias = each.value.private_endpoint.private_service_connection.private_connection_resource_alias
      subresource_names                 = each.value.private_endpoint.private_service_connection.subresource_names
      request_message                   = each.value.private_endpoint.private_service_connection.request_message
    }
  }

  dynamic "ip_configuration" {
    for_each = coalesce(each.value.private_endpoint.ip_configuration, [])

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

resource "azurerm_role_assignment" "storage_account" {
  for_each = {
    for assignment in local.azure_storage_account_role_assignment : assignment.resource_index => assignment
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

  timeouts {
    # Default for all resources
    create = "15m"
    delete = "15m"
  }
}
