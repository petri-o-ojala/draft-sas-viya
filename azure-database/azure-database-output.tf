#
# Terraform module outputs
#

output "azure_postgresql_server" {
  description = "Azure Database - PostgreSQL"
  value       = azurerm_postgresql_server.lz
}
