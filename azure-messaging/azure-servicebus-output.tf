#
# Terraform module outputs
#

output "azure_servicebus_namespace" {
  description = "Azure Service Bus Namespaces"
  value       = azurerm_servicebus_namespace.lz
}
