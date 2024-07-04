#
# SAS Viya PostgreSQL
#

module "sas_viya_postgresql" {
  source = "./azure-database"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common   = var.sas_viya_common
  database = var.sas_viya_postgresql
}
