#
# Azure Storage Accounts
#

variable "storage" {
  description = "Azure Storage Accounts"
  type = object({
    account = optional(map(object({
      name                              = string
      resource_group_name               = string
      location                          = string
      account_kind                      = optional(string)
      account_tier                      = string
      account_replication_type          = string
      cross_tenant_replication_enabled  = optional(bool)
      access_tier                       = optional(string)
      enable_https_traffic_only         = optional(bool)
      min_tls_version                   = optional(string)
      shared_access_key_enabled         = optional(bool)
      public_network_access_enabled     = optional(bool)
      default_to_oauth_authentication   = optional(bool)
      is_hns_enabled                    = optional(bool)
      nfsv3_enabled                     = optional(bool)
      large_file_share_enabled          = optional(bool)
      local_user_enabled                = optional(bool)
      queue_encryption_key_type         = optional(string)
      table_encryption_key_type         = optional(string)
      infrastructure_encryption_enabled = optional(bool)
      allowed_copy_scope                = optional(string)
      sftp_enabled                      = optional(bool)
      allow_nested_items_to_be_public   = optional(bool)
      tags                              = optional(map(string))
      management_lock = optional(object({
        name       = optional(string)
        lock_level = optional(string, "CanNotDelete")
        notes      = optional(string)
      }))
      identity = optional(object({
        type         = optional(string)
        identity_ids = optional(list(string))
      }))
      diagnostic_setting = optional(list(object({
        name                           = optional(string)
        service                        = optional(string)
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
      })))
      private_endpoint = optional(list(object({
        name                          = string
        resource_group_name           = optional(string)
        location                      = optional(string)
        subnet_id                     = optional(string)
        custom_network_interface_name = optional(string)
        tags                          = optional(map(string))
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
      custom_domain = optional(object({
        name          = string
        use_subdomain = optional(bool)

      }))
      customer_managed_key = optional(object({
        key_vault_key_id          = string
        user_assigned_identity_id = optional(string)
      }))
      blob_properties = optional(object({
        versioning_enabled            = optional(bool)
        change_feed_enabled           = optional(bool)
        change_feed_retention_in_days = optional(number)
        default_service_version       = optional(string)
        last_access_time_enabled      = optional(bool)
        cors_rule = optional(object({
          allowed_headers    = list(string)
          allowed_methods    = list(string)
          allowed_origins    = list(string)
          exposed_headers    = list(string)
          max_age_in_seconds = number
        }))
        delete_retention_policy = optional(object({
          days = number
        }))
        restore_policy = optional(object({
          days = number
        }))
        container_delete_retention_policy = optional(object({
          days = number
        }))
      }))
      network_rules = optional(object({
        default_action             = string
        bypass                     = optional(list(string))
        ip_rules                   = optional(list(string))
        virtual_network_subnet_ids = optional(list(string))
        private_link_access = optional(list(object({
          endpoint_resource_id = string
          endpoint_tenant_id   = optional(string)
        })))
      }))
      container = optional(list(object({
        name                              = string
        storage_account_name              = optional(string)
        container_access_type             = optional(string)
        default_encryption_scope          = optional(string)
        encryption_scope_override_enabled = optional(bool)
        metadata                          = optional(map(string))
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
      for resource_id, resource in local.azure_resource_principal_id : resource_id => resource.identity[0].principal_id
      if try(resource.identity[0].principal_id, null) != null
    }
  )

  #
  # Azure Storage Accounts
  #
  azure_storage_account = flatten([
    for account_id, account in coalesce(try(var.storage.account, null), {}) : merge(
      account,
      {
        resource_index = join("_", [account_id])
      }
    )
  ])

  azure_storage_account_diagnostic_setting = flatten([
    for account_id, account in coalesce(try(var.storage.account, null), {}) : [
      for diagnostic_setting in coalesce(account.diagnostic_setting, []) : merge(
        account,
        {
          diagnostic_setting             = diagnostic_setting
          target_resource_id_suffix      = diagnostic_setting.service == null ? "" : "/${diagnostic_setting.service}/default/"
          storage_account_resource_index = join("_", [account_id])
          resource_index                 = join("_", [account_id, coalesce(diagnostic_setting.service, "default")])
        }
      )
    ]
    if account.diagnostic_setting != null
  ])

  azure_storage_account_private_endpoint = flatten([
    for account_id, account in coalesce(try(var.storage.account, null), {}) : [
      for private_endpoint in coalesce(account.private_endpoint, []) : merge(
        account,
        {
          private_endpoint = merge(
            private_endpoint,
            {
              resource_group_name = coalesce(private_endpoint.resource_group_name, account.resource_group_name)
              location            = coalesce(private_endpoint.location, account.location)
            }
          )
          storage_account_resource_index = join("_", [account_id])
          resource_index                 = join("_", [account_id, coalesce(private_endpoint.private_service_connection.name, "default")])
        }
      )
    ]
    if account.private_endpoint != null
  ])

  azure_storage_account_role_assignment = flatten([
    for account_id, account in coalesce(try(var.storage.account, null), {}) : [
      for iam_id, iam in coalesce(account.iam, []) : [
        for principal in coalesce(try(iam.principal_id, null), []) : merge(
          iam,
          {
            scope          = local.azurerm_storage_account[account_id].id
            principal_id   = principal
            resource_index = join("_", [account_id, coalesce(iam.role_definition_name, iam.role_definition_id), principal])
          }
        )
      ]
    ]
    if account.iam != null
  ])
  #
  # Azure Storage Account Containers
  #
  azure_storage_container = flatten([
    # Containers as part of Storage Account configuration    
    for account_id, account in coalesce(try(var.storage.account, null), {}) : [
      for container in coalesce(account.container, []) : merge(
        container,
        {
          storage_account_id            = account_id
          storage_account_configuration = account
          storage_account_name          = local.azurerm_storage_account[account_id].name
          resource_index                = join("_", [account_id, container.name])
        }
      )
    ]
  ])

  azure_storage_container_iam = flatten([
    for account_id, account in coalesce(try(var.storage.account, null), {}) : [
      for container in coalesce(account.container, []) : [
        for iam_id, iam in coalesce(container.iam, []) : [
          for principal in coalesce(try(iam.principal_id, null), []) : merge(
            iam,
            {
              scope          = local.azurerm_storage_container[join("_", [account_id, container.name])].resource_manager_id
              principal_id   = principal
              resource_index = join("_", [account_id, container.name, coalesce(iam.role_definition_name, iam.role_definition_id), principal])
            }
          )
        ]
      ]
    ]
  ])

}
