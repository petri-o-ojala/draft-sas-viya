#
# SAS Viya Common Infrastructure
#

module "sas_viya_resource_group" {
  source = "./azure-resource-group"

  common         = var.sas_viya_common
  resource_group = var.sas_viya_resource_group
}

/*
#
# JOD Network
#

module "sas_viya_network_security_group" {
  source = "./azure-network-security-group"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common           = var.sas_viya_common
  network_security = var.sas_viya_network_security_group
}

module "sas_viya_network" {
  source = "./azure-network"

  reference = {
    azure_resource_group         = module.sas_viya_resource_group.azure_resource_group
    azure_network_security_group = module.sas_viya_network_security_group.azure_network_security_group
  }

  common  = var.sas_viya_common
  network = var.sas_viya_network
}

module "sas_viya_network_peering_iam" {
  source = "./azure-authorization"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common = var.sas_viya_common
  role   = var.sas_viya_network_peering_iam

  depends_on = [
    module.sas_viya_network
  ]
}

module "sas_viya_network_private_endpoint" {
  source = "./azure-network"

  reference = {
    azure_resource_group   = module.sas_viya_resource_group.azure_resource_group
    azure_private_dns_zone = module.sas_viya_dns.azure_private_dns_zone
    azure_subnet           = module.sas_viya_network.azure_subnet
  }

  common = var.sas_viya_common

  network = var.sas_viya_network_private_endpoint
}

module "sas_viya_dns" {
  source = "./azure-dns"

  reference = {
    azure_resource_group  = module.sas_viya_resource_group.azure_resource_group
    azure_virtual_network = module.sas_viya_network.azure_virtual_network
  }

  common = var.sas_viya_common
  dns    = var.sas_viya_dns

  depends_on = [
    module.sas_viya_network
  ]
}

#
# Azure Storage
#

module "sas_viya_storage" {
  source = "./azure-storage-account"

  reference = {
    azure_resource_group          = module.sas_viya_resource_group.azure_resource_group
    azure_network_security_group  = module.sas_viya_network_security_group.azure_network_security_group
    azure_log_analytics_workspace = module.sas_viya_log_analytics.azure_log_analytics_workspace
    azure_private_dns_zone        = module.sas_viya_dns.azure_private_dns_zone
    azure_subnet                  = module.sas_viya_network.azure_subnet
    azure_resource_principal_id = merge(
      {
        for resource_id, resource in module.sas_viya_data_factory.azure_data_factory : "data-factory-account-${resource_id}" => resource
      }
    )
  }

  entra_id = var.df_entra_id
  common   = var.sas_viya_common
  storage  = var.sas_viya_storage
}
#
# Azure Key Vaults
#

module "sas_viya_keyvault" {
  source = "./azure-keyvault"

  reference = {
    azure_resource_group          = module.sas_viya_resource_group.azure_resource_group
    azure_subnet                  = module.sas_viya_network.azure_subnet
    azure_storage_account         = module.sas_viya_storage.azure_storage_account
    azure_log_analytics_workspace = module.sas_viya_log_analytics.azure_log_analytics_workspace
    azure_private_dns_zone        = module.sas_viya_dns.azure_private_dns_zone
    azure_resource_principal_id = merge(
      {
        for resource_id, resource in module.sas_viya_data_factory.azure_data_factory : "data-factory-account-${resource_id}" => resource.identity[0].principal_id
        if try(resource.identity[0].principal_id, null) != null
      },
      {
        for resource_id, resource in module.sas_viya_identity.azure_user_assigned_identity : "user-assigned-identity-${resource_id}" => resource.principal_id
      }
    )
  }

  entra_id = var.df_entra_id
  common   = var.sas_viya_common
  keyvault = var.sas_viya_keyvault
}

#
# Azure Log Analytics Workspace
#

module "sas_viya_log_analytics" {
  source = "./azure-log-analytics"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common        = var.sas_viya_common
  log_analytics = var.sas_viya_log_analytics
}

#
# Azure Monitor
#

module "sas_viya_monitor" {
  source = "./azure-monitor"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common  = var.sas_viya_common
  monitor = var.sas_viya_monitor

  depends_on = [
    module.sas_viya_log_analytics
  ]
}

#
# Azure Backup
#

module "sas_viya_backup" {
  source = "./azure-backup"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common = var.sas_viya_common
  backup = var.sas_viya_backup
}
*/
