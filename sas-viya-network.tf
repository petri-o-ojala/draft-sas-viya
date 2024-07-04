#
# SAS Viya Azure NetApp Files
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

module "sas_viya_network_private_endpoint" {
  source = "./azure-network"

  reference = {
    azure_resource_group   = module.sas_viya_resource_group.azure_resource_group
    azure_private_dns_zone = module.sas_viya_dns.azure_private_dns_zone
    azure_subnet           = module.sas_viya_network.azure_subnet
  }

  common  = var.sas_viya_common
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
