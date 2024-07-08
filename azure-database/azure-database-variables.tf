#
# Azure Database
#

variable "database" {
  description = "Azure Database"
  type = object({
    postgresql_flexible = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server
      name                              = string
      resource_group_name               = string
      location                          = string
      tags                              = optional(map(string))
      administrator_login               = string
      administrator_password            = optional(string)
      backup_retention_days             = optional(number)
      geo_redundant_backup_enabled      = optional(bool)
      create_mode                       = optional(string)
      delegated_subnet_id               = optional(string)
      private_dns_zone_id               = optional(string)
      public_network_access_enabled     = optional(bool)
      point_in_time_restore_time_in_utc = optional(string)
      replication_role                  = optional(string)
      sku_name                          = optional(string)
      source_server_id                  = optional(string)
      auto_grow_enabled                 = optional(bool)
      storage_mb                        = optional(number)
      storage_tier                      = optional(string)
      version                           = optional(string)
      zone                              = optional(string)
      authentication = optional(object({
        active_directory_auth_enabled = optional(bool)
        password_auth_enabled         = optional(bool)
        tenant_id                     = optional(string)
      }))
      customer_managed_key = optional(object({
        key_vault_key_id                     = string
        primary_user_assigned_identity_id    = optional(string)
        geo_backup_key_vault_key_id          = optional(string)
        geo_backup_user_assigned_identity_id = optional(string)
      }))
      high_availability = optional(object({
        mode                      = string
        standby_availability_zone = optional(string)
      }))
      identity = optional(object({
        type         = string
        identity_ids = list(string)
      }))
      maintenance_window = optional(object({
        day_of_week  = optional(number)
        start_hour   = optional(number)
        start_minute = optional(number)
      }))
      configuration = optional(list(object({
        # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_configuration
        name  = string
        value = string
      })))
      firewall_rule = optional(list(object({
        # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/postgresql_flexible_server_firewall_rule
        name             = string
        start_ip_address = string
        end_ip_address   = string
      })))
    })))
    mssql_virtual_machine = optional(map(object({
      virtual_machine_id               = string
      sql_license_type                 = optional(string)
      r_services_enabled               = optional(bool)
      sql_connectivity_port            = optional(number)
      sql_connectivity_type            = optional(string)
      sql_connectivity_update_password = optional(string)
      sql_connectivity_update_username = optional(string)
      sql_virtual_machine_group_id     = optional(string)
      tags                             = optional(map(string))
      auto_backup = optional(object({
        encryption_enabled              = optional(bool)
        encryption_password             = optional(string)
        retention_period_in_days        = optional(number)
        storage_blob_endpoint           = optional(string)
        storage_account_access_key      = optional(string)
        system_databases_backup_enabled = optional(bool)
        manual_schedule = optional(object({
          full_backup_frequency           = string
          full_backup_start_hour          = number
          full_backup_window_in_hours     = number
          log_backup_frequency_in_minutes = number
          days_of_week                    = optional(list(string))
        }))
      }))
      auto_patching = optional(object({
        day_of_week                            = string
        maintenance_window_starting_hour       = number
        maintenance_window_duration_in_minutes = number
      }))
      key_vault_credential = optional(object({
        name                     = string
        key_vault_url            = string
        service_principal_name   = string
        service_principal_secret = string
      }))
      sql_instance = optional(object({
        adhoc_workloads_optimization_enabled = optional(bool)
        collation                            = optional(string)
        instant_file_initialization_enabled  = optional(bool)
        lock_pages_in_memory_enabled         = optional(bool)
        max_dop                              = optional(number)
        max_server_memory_mb                 = optional(number)
        min_server_memory_mb                 = optional(number)
      }))
      storage_configuration = optional(object({
        disk_type                      = string
        storage_workload_type          = string
        system_db_on_data_disk_enabled = optional(bool)
        data_settings = optional(object({
          default_file_path = string
          luns              = list(string)
        }))
        log_settings = optional(object({
          default_file_path = string
          luns              = list(string)
        }))
        temp_db_settings = optional(object({
          default_file_path      = string
          luns                   = list(string)
          data_file_count        = optional(number)
          data_file_size_mb      = optional(number)
          data_file_growth_in_mb = optional(number)
          log_file_size_mb       = optional(number)
          log_file_growth_mb     = optional(number)
        }))
      }))
      assessment = optional(object({
        enabled         = optional(bool)
        run_immediately = optional(bool)
        schedule = optional(object({
          weekly_interval    = optional(number)
          monthly_occurrence = optional(number)
          day_of_week        = string
          start_time         = string
        }))
      }))
      wsfc_domain_credential = optional(object({
        cluster_bootstrap_account_password = string
        cluster_operator_account_password  = string
        sql_service_account_password       = string
      }))
    })))
    mssql_instance = optional(map(object({
      name                           = string
      resource_group_name            = string
      location                       = string
      license_type                   = string
      sku_name                       = string
      administrator_login            = string
      administrator_login_password   = string
      vcores                         = number
      storage_size_in_gb             = number
      subnet_id                      = string
      tags                           = optional(map(string))
      collation                      = optional(string)
      dns_zone_partner_id            = optional(string)
      maintenance_configuration_name = optional(string)
      minimum_tls_version            = optional(string)
      proxy_override                 = optional(bool)
      public_data_endpoint_enabled   = optional(bool)
      storage_account_type           = optional(string)
      zone_redundant_enabled         = optional(bool)
      timezone_id                    = optional(string)
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
    })))
    postgresql = optional(map(object({
      name                              = string
      resource_group_name               = string
      location                          = string
      sku_name                          = string
      version                           = string
      ssl_enforcement_enabled           = bool
      tags                              = optional(map(string))
      administrator_login               = optional(string)
      administrator_login_password      = optional(string)
      auto_grow_enabled                 = optional(bool)
      backup_retention_days             = optional(number)
      create_mode                       = optional(string)
      creation_source_server_id         = optional(string)
      geo_redundant_backup_enabled      = optional(bool)
      infrastructure_encryption_enabled = optional(bool)
      public_network_access_enabled     = optional(bool)
      restore_point_in_time             = optional(string)
      ssl_minimal_tls_version_enforced  = optional(string)
      storage_mb                        = optional(number)
      identity = optional(object({
        type = string
      }))
      threat_detection_policy = optional(object({
        enabled                    = optional(bool)
        disabled_alerts            = optional(list(string))
        email_account_admins       = optional(bool)
        email_addresses            = optional(list(string))
        retention_days             = optional(number)
        storage_account_access_key = optional(string)
        storage_endpoint           = optional(string)
      }))
      virtual_network_rule = optional(list(object({
        name                                 = string
        resource_group_name                  = optional(string)
        server_name                          = optional(string)
        subnet_id                            = string
        ignore_missing_vnet_service_endpoint = optional(bool)
      })))
      active_directory_administrator = optional(list(object({
        server_name         = optional(string)
        resource_group_name = optional(string)
        login               = string
        tenant_id           = string
        object_id           = string
      })))
      firewall_rule = optional(list(object({
        name                = string
        server_name         = optional(string)
        resource_group_name = optional(string)
        start_ip_address    = string
        end_ip_address      = string
      })))
      database = optional(list(object({
        name                = string
        server_name         = optional(string)
        resource_group_name = optional(string)
        charset             = string
        collation           = string
      })))
      management_lock = optional(object({
        name       = optional(string)
        lock_level = optional(string)
        notes      = optional(string)
      }))
    })))
  })
  default = {}
}

variable "common" {
  #
  # Common data for all resources
  #
  description = "Common Azure resource parameters"
  type = object({
    tags            = optional(map(string))
    custom_metadata = optional(map(string))
  })
  default = {}
}

locals {
  # Use local variable to allow easier long-term development
  common = var.common

  #
  # Azure Database - PostgreSQL
  #
  azure_postgresql_server = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql, null), {}) : merge(
      postgresql,
      {
        resource_index = join("_", [postgresql_id])
      }
    )
  ])

  azure_postgresql_virtual_network_rule = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql, null), {}) : [
      for rule in coalesce(postgresql.virtual_network_rule, []) : merge(
        rule,
        {
          server_name         = coalesce(rule.server_name, local.azurerm_postgresql_server[postgresql_id].name)
          resource_group_name = coalesce(rule.resource_group_name, local.azurerm_postgresql_server[postgresql_id].resource_group_name)
          resource_index      = join("_", [postgresql_id, rule.name])
        }
      )
    ]
  ])

  azure_postgresql_active_directory_administrator = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql, null), {}) : [
      for admin in coalesce(postgresql.active_directory_administrator, []) : merge(
        admin,
        {
          server_name         = coalesce(admin.server_name, local.azurerm_postgresql_server[postgresql_id].name)
          resource_group_name = coalesce(admin.resource_group_name, local.azurerm_postgresql_server[postgresql_id].resource_group_name)
          resource_index      = join("_", [postgresql_id, admin.login])
        }
      )
    ]
  ])

  azure_postgresql_firewall_rule = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql, null), {}) : [
      for rule in coalesce(postgresql.firewall_rule, []) : merge(
        rule,
        {
          server_name         = coalesce(rule.server_name, local.azurerm_postgresql_server[postgresql_id].name)
          resource_group_name = coalesce(rule.resource_group_name, local.azurerm_postgresql_server[postgresql_id].resource_group_name)
          resource_index      = join("_", [postgresql_id, rule.name])
        }
      )
    ]
  ])

  azure_postgresql_database = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql, null), {}) : [
      for database in coalesce(postgresql.database, []) : merge(
        database,
        {
          server_name         = coalesce(database.server_name, local.azurerm_postgresql_server[postgresql_id].name)
          resource_group_name = coalesce(database.resource_group_name, local.azurerm_postgresql_server[postgresql_id].resource_group_name)
          resource_index      = join("_", [postgresql_id, database.name])
        }
      )
    ]
  ])

  azure_mssql_managed_instance = flatten([
    for mssql_id, mssql in coalesce(try(var.database.mssql_instance, null), {}) : merge(
      mssql,
      {
        resource_index = join("_", [mssql_id])
      }
    )
  ])

  azure_mssql_virtual_machine = flatten([
    for mssql_id, mssql in coalesce(try(var.database.mssql_virtual_machine, null), {}) : merge(
      mssql,
      {
        resource_index = join("_", [mssql_id])
      }
    )
  ])

  azure_postgresql_flexible_server = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql_flexible, null), {}) : merge(
      postgresql,
      {
        resource_index = join("_", [postgresql_id])
      }
    )
  ])

  azure_postgresql_flexible_server_configuration = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql_flexible, null), {}) : [
      for configuration in coalesce(postgresql.configuration, []) : merge(
        configuration,
        {
          server_id      = azurerm_postgresql_flexible_server.lz[postgresql_id].id
          resource_index = join("_", [postgresql_id, configuration.name])
        }
      )
    ]
  ])

  azure_postgresql_flexible_server_firewall_rule = flatten([
    for postgresql_id, postgresql in coalesce(try(var.database.postgresql_flexible, null), {}) : [
      for rule in coalesce(postgresql.firewall_rule, []) : merge(
        rule,
        {
          server_id      = azurerm_postgresql_flexible_server.lz[postgresql_id].id
          resource_index = join("_", [postgresql_id, rule.name])
        }
      )
    ]
  ])
}
