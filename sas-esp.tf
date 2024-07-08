#
# SAS ESP Common Infrastructure
#

module "sas_esp_resource_group" {
  source = "./azure-resource-group"

  common         = var.sas_esp_common
  resource_group = var.sas_esp_resource_group
}

module "sas_esp_log_analytics" {
  source = "./azure-log-analytics"

  reference = {
    azure_resource_group = module.sas_esp_resource_group.azure_resource_group
  }

  common        = var.sas_esp_common
  log_analytics = var.sas_esp_log_analytics
}
