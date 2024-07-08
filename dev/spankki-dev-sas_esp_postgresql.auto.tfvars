#
# SAS ESP Azure PostgreSQL

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

#
# This is not enabled by default in viya4-iac-azure
#

/*
sas_esp_postgresql = {
  postgresql_flexible = {
    "sas-esp" = {
      name                          = "flexpsql-spankki-afc-esp-we-sas-dev"
      resource_group_name           = "rg-spankki-afc-esp-we-postgresql-dev"
      location                      = "westeurope"
      version                       = "15"
      private_dns_zone_id           = "privatelink-postgresql"
      delegated_subnet_id           = "sas-esp-dev_sas-esp-dev-postgresql"
      public_network_access_enabled = false
      administrator_login           = "psqladmin"
      administrator_password        = "H@Sh1CoR3!"
      zone                          = "2"
      storage_mb                    = 32768
      storage_tier                  = "P30"
      sku_name                      = "GP_Standard_D4ds_v5"
      firewall_rule = [
        {
          name             = "Allow-public-access-from-any-Azure-service"
          start_ip_address = "0.0.0.0"
          end_ip_address   = "0.0.0.0"
        }
      ]
    }
  }
}
*/
