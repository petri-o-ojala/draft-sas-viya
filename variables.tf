#
# SAS Viya
#

variable "sas_viya_common" {
  description = "SAS Viya Common settings"
  type        = any
  default     = {}
}

variable "spankki_entra_id" {
  description = "S-Pankki Entra ID configuration"
  type        = any
  default     = {}
}

#
# Common infrastructure
#

variable "sas_viya_resource_group" {
  description = "SAS Viya Resource Groups"
  type        = any
  default     = {}
}

#
# Azure Networking
#

variable "sas_viya_network" {
  description = "SAS Viya VNet Network"
  type        = any
  default     = {}
}

variable "sas_viya_network_private_endpoint" {
  description = "SAS Viya Private Endpoints"
  type        = any
  default     = {}
}

variable "sas_viya_network_security_group" {
  description = "SAS Viya Network Security Groups"
  type        = any
  default     = {}
}

variable "sas_viya_dns" {
  description = "SAS Viya DNS Zones"
  type        = any
  default     = {}
}

#
# AKS 
#

variable "sas_viya_aks" {
  description = "SAS Viya AKS Cluster"
  type        = any
  default     = {}
}

#
# ACR
#

variable "sas_viya_acr" {
  description = "SAS Viya Azure Container Registry"
  type        = any
  default     = {}
}

#
# Azure PostgreSQL
#

variable "sas_viya_postgresql" {
  description = "SAS Viya Azure PostgreSQL"
  type        = any
  default     = {}
}

#
# Azure Serviec Bus
#

variable "sas_viya_servicebus" {
  description = "SAS Viya Azure Service Bus"
  type        = any
  default     = {}
}

#
# Azure NetApp Files
#

variable "sas_viya_anf" {
  description = "SAS Viya Azure NetApp Files"
  type        = any
  default     = {}
}


#
#
#
#
#

variable "sas_viya_identity" {
  description = "SAS Viya Identities"
  type        = any
  default     = {}
}

variable "sas_viya_identity_role" {
  description = "SAS Viya Identity Roles and role assignments"
  type        = any
  default     = {}
}

variable "sas_viya_iam_role" {
  description = "HYTE IAM Role assignments"
  type        = any
  default     = {}
}

variable "sas_viya_storage" {
  description = "SAS Viya Storage Accounts"
  type        = any
  default     = {}
}

variable "sas_viya_keyvault" {
  description = "SAS Viya Keyvaults"
  type        = any
  default     = {}
}

variable "sas_viya_log_analytics" {
  description = "SAS Viya Log Analytics Workspaces"
  type        = any
  default     = {}
}

variable "sas_viya_data_factory" {
  description = "SAS Viya Data Factories"
  type        = any
  default     = {}
}

variable "sas_viya_mssql_virtual_machine" {
  description = "SAS Viya MS SQL Virtual Machines"
  type        = any
  default     = {}
}

variable "sas_viya_mssql" {
  description = "SAS Viya MS SQL Virtual Machines"
  type        = any
  default     = {}
}

variable "sas_viya_monitor" {
  description = "SAS Viya Azure Monitor"
  type        = any
  default     = {}
}

variable "sas_viya_backup" {
  description = "SAS Viya Azure Backup"
  type        = any
  default     = {}
}

variable "sas_viya_ws_virtual_machine" {
  description = "SAS Viya Wherescape VMs"
  type        = any
  default     = {}
}

variable "sas_viya_ws_virtual_machine_keyvault" {
  description = "SAS Viya Wherescape VM Accounts"
  type        = any
  default     = {}
}

variable "sas_viya_shir_virtual_machine" {
  description = "SAS Viya SHIR VMs"
  type        = any
  default     = {}
}

variable "sas_viya_shir_virtual_machine_keyvault" {
  description = "SAS Viya SHIR VM Accounts"
  type        = any
  default     = {}

}

variable "sas_viya_maintenance" {
  description = "Azure Maintenance Update Manager configuration"
  type        = any
  default     = {}
}

variable "sas_viya_policy" {
  description = "Azure Policies"
  type        = any
  default     = {}
}

variable "sas_viya_azure_defender" {
  description = "Azure Defender"
  type        = any
  default     = {}
}
