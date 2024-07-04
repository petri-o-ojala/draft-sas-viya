#
# Azure Database - Managed MS SQL Instance
#

locals {
  azurerm_mssql_virtual_machine = azurerm_mssql_virtual_machine.lz
}

resource "azurerm_mssql_virtual_machine" "lz" {
  for_each = {
    for vm in local.azure_mssql_virtual_machine : vm.resource_index => vm
  }

  virtual_machine_id = lookup(local.azure_windows_virtual_machine, each.value.virtual_machine_id, null) == null ? each.value.virtual_machine_id : local.azure_windows_virtual_machine[each.value.virtual_machine_id].id

  sql_license_type                 = each.value.sql_license_type
  r_services_enabled               = each.value.r_services_enabled
  sql_connectivity_port            = each.value.sql_connectivity_port
  sql_connectivity_type            = each.value.sql_connectivity_type
  sql_connectivity_update_password = each.value.sql_connectivity_update_password
  sql_connectivity_update_username = each.value.sql_connectivity_update_username
  sql_virtual_machine_group_id     = each.value.sql_virtual_machine_group_id

  tags = merge(
    each.value.tags,
    local.common.tags
  )


  dynamic "auto_backup" {
    for_each = try(each.value.auto_backup, null) == null ? [] : [1]

    content {
      encryption_enabled              = each.value.auto_backup.encryption_enabled
      encryption_password             = each.value.auto_backup.encryption_password
      retention_period_in_days        = each.value.auto_backup.retention_period_in_days
      storage_blob_endpoint           = each.value.auto_backup.storage_blob_endpoint
      storage_account_access_key      = each.value.auto_backup.storage_account_access_key
      system_databases_backup_enabled = each.value.auto_backup.system_databases_backup_enabled

      dynamic "manual_schedule" {
        for_each = try(each.value.auto_backup.manual_schedule, null) == null ? [] : [1]

        content {
          full_backup_frequency           = each.value.auto_backup.manual_schedule.full_backup_frequency
          full_backup_start_hour          = each.value.auto_backup.manual_schedule.full_backup_start_hour
          full_backup_window_in_hours     = each.value.auto_backup.manual_schedule.full_backup_window_in_hours
          log_backup_frequency_in_minutes = each.value.auto_backup.manual_schedule.log_backup_frequency_in_minutes
          days_of_week                    = each.value.auto_backup.manual_schedule.days_of_week
        }
      }
    }
  }

  dynamic "auto_patching" {
    for_each = try(each.value.auto_patching, null) == null ? [] : [1]

    content {
      day_of_week                            = each.value.auto_patching.day_of_week
      maintenance_window_starting_hour       = each.value.auto_patching.maintenance_window_starting_hour
      maintenance_window_duration_in_minutes = each.value.auto_patching.daymaintenance_window_duration_in_minutes_of_week
    }
  }

  dynamic "key_vault_credential" {
    for_each = try(each.value.key_vault_credential, null) == null ? [] : [1]

    content {
      name                     = each.value.key_vault_credential.name
      key_vault_url            = each.value.key_vault_credential.key_vault_url
      service_principal_name   = each.value.key_vault_credential.service_principal_name
      service_principal_secret = each.value.key_vault_credential.service_principal_secret
    }
  }

  dynamic "sql_instance" {
    for_each = try(each.value.key_vault_credential, null) == null ? [] : [1]

    content {
      adhoc_workloads_optimization_enabled = each.value.key_vault_credential.adhoc_workloads_optimization_enabled
      collation                            = each.value.key_vault_credential.collation
      instant_file_initialization_enabled  = each.value.key_vault_credential.instant_file_initialization_enabled
      lock_pages_in_memory_enabled         = each.value.key_vault_credential.lock_pages_in_memory_enabled
      max_dop                              = each.value.key_vault_credential.max_dop
      max_server_memory_mb                 = each.value.key_vault_credential.max_server_memory_mb
      min_server_memory_mb                 = each.value.key_vault_credential.min_server_memory_mb
    }
  }

  dynamic "storage_configuration" {
    for_each = try(each.value.storage_configuration, null) == null ? [] : [1]

    content {
      disk_type                      = each.value.storage_configuration.disk_type
      storage_workload_type          = each.value.storage_configuration.storage_workload_type
      system_db_on_data_disk_enabled = each.value.storage_configuration.system_db_on_data_disk_enabled

      dynamic "data_settings" {
        for_each = try(each.value.storage_configuration.data_settings, null) == null ? [] : [1]

        content {
          default_file_path = each.value.storage_configuration.data_settings.default_file_path
          luns              = each.value.storage_configuration.data_settings.luns
        }
      }

      dynamic "log_settings" {
        for_each = try(each.value.storage_configuration.log_settings, null) == null ? [] : [1]

        content {
          default_file_path = each.value.storage_configuration.log_settings.default_file_path
          luns              = each.value.storage_configuration.log_settings.luns
        }
      }

      dynamic "temp_db_settings" {
        for_each = try(each.value.storage_configuration.temp_db_settings, null) == null ? [] : [1]

        content {
          default_file_path      = each.value.storage_configuration.temp_db_settings.default_file_path
          luns                   = each.value.storage_configuration.temp_db_settings.luns
          data_file_count        = each.value.storage_configuration.temp_db_settings.data_file_count
          data_file_size_mb      = each.value.storage_configuration.temp_db_settings.data_file_size_mb
          data_file_growth_in_mb = each.value.storage_configuration.temp_db_settings.data_file_growth_in_mb
          log_file_size_mb       = each.value.storage_configuration.temp_db_settings.log_file_size_mb
          log_file_growth_mb     = each.value.storage_configuration.temp_db_settings.log_file_growth_mb
        }
      }
    }
  }

  dynamic "assessment" {
    for_each = try(each.value.assessment, null) == null ? [] : [1]

    content {
      enabled         = each.value.assessment.enabled
      run_immediately = each.value.assessment.run_immediately

      dynamic "schedule" {
        for_each = try(each.value.assessment.schedule, null) == null ? [] : [1]

        content {
          weekly_interval    = each.value.assessment.schedule.weekly_interval
          monthly_occurrence = each.value.assessment.schedule.monthly_occurrence
          day_of_week        = each.value.assessment.schedule.day_of_week
          start_time         = each.value.assessment.schedule.start_time
        }
      }
    }
  }

  dynamic "wsfc_domain_credential" {
    for_each = try(each.value.wsfc_domain_credential, null) == null ? [] : [1]

    content {
      cluster_bootstrap_account_password = each.value.wsfc_domain_credential.cluster_bootstrap_account_password
      cluster_operator_account_password  = each.value.wsfc_domain_credential.cluster_operator_account_password
      sql_service_account_password       = each.value.wsfc_domain_credential.sql_service_account_password
    }
  }
}
