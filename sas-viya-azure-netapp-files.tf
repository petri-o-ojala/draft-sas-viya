#
# SAS Viya Azure NetApp Files
#

module "sas_viya_anf" {
  source = "./azure-netapp-files"

  reference = {
    azure_resource_group = module.sas_viya_resource_group.azure_resource_group
  }

  common = var.sas_viya_common
  anf    = var.sas_viya_anf
}
