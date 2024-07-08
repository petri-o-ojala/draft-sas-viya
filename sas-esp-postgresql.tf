#
# SAS ESP PostgreSQL
#

module "sas_esp_postgresql" {
  source = "./azure-database"

  reference = {
    azure_resource_group   = module.sas_esp_resource_group.azure_resource_group
    azure_subnet           = module.sas_esp_network.azure_subnet
    azure_private_dns_zone = module.sas_esp_dns.azure_private_dns_zone
  }

  common   = var.sas_esp_common
  database = var.sas_esp_postgresql
}
