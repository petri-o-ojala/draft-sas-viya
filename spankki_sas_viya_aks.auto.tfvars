#
# SAS Viya Azure Kubernetes Service
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_viya_aks = {
  cluster = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
    "sas-viya" = {
      resource_group_name = "rg-spankki-afc-esp-we-aks-dev"
      location            = "westeurope"
      name                = "aks-spankki-afc-esp-we-sas-dev"
      dns_prefix          = "spankki"
      default_node_pool = {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_D2_v2"
      }
      identity = {
        type = "SystemAssigned"
      }
    }
  }
  node_pool = {
    "sas-viya-compute" = {
      name                  = "compute"
      kubernetes_cluster_id = "sas-viya"
      vm_size               = "Standard_DS2_v2"
      node_count            = 1
    }
  }
}
