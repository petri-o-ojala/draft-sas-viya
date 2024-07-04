#
# SAS Viya Azure PostgreSQL

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_viya_postgresql = {
  postgresql_flexible = {
    "sas-viya" = {
      name                          = "psql-spankki-afc-esp-we-sas-dev"
      resource_group_name           = "rg-spankki-afc-esp-we-postgresql-dev"
      location                      = "westeurope"
      version                       = "12"
      delegated_subnet_id           = "/subscriptions/b6f220d6-473b-4f8a-a8d5-bbfdf652a0df/resourceGroups/rg-ismok-bicep-dev/providers/Microsoft.Network/virtualNetworks/testvnet/subnets/subnet1"
      public_network_access_enabled = false
      administrator_login           = "psqladmin"
      administrator_password        = "H@Sh1CoR3!"
      zone                          = "1"
      storage_mb                    = 32768
      storage_tier                  = "P30"
      sku_name                      = "GP_Standard_D4s_v3"
    }
  }
}
