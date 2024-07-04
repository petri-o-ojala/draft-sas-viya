#
# Terraform module outputs
#

output "azure_kubernetes_cluster" {
  description = "Azure AKS Clusters"
  value       = azurerm_kubernetes_cluster.lz
}
