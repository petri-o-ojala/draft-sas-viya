#
# SAS ESP
#

variable "sas_esp_common" {
  description = "SAS ESP Common settings"
  type        = any
  default     = {}
}

variable "spankki_entra_id" {
  description = "S-Pankki Entra ID configuration"
  type        = any
  default     = {}
}

variable "sas_esp_tietoevry_azure_terraform" {
  description = "S-Pankki ESP Terraform resources"
  type        = any
  default     = {}
}

#
# Common infrastructure
#

variable "sas_esp_resource_group" {
  description = "SAS ESP Resource Groups"
  type        = any
  default     = {}
}

variable "sas_esp_log_analytics" {
  description = "SAS ESP Log Analytics Workspaces"
  type        = any
  default     = {}
}

#
# Confluent Cloud
#

variable "sas_esp_confluent_cloud_kafka" {
  description = "SAS ESP Confluent Cloud Kafka environment"
  type        = any
  default     = {}
}

variable "sas_esp_confluent_cloud_kafka_ops_team" {
  description = "SAS ESP Confluent Cloud Kafka OPS-Team"
  type        = any
  default     = {}
}

variable "sas_esp_confluent_cloud_kafka_admin_product_team" {
  description = "SAS ESP Confluent Cloud Kafka Admin Product team"
  type        = any
  default     = {}
}

#
# Azure Networking
#

variable "sas_esp_network" {
  description = "SAS ESP VNet Network"
  type        = any
  default     = {}
}

variable "sas_esp_network_private_endpoint" {
  description = "SAS ESP Private Endpoints"
  type        = any
  default     = {}
}

variable "sas_esp_network_security_group" {
  description = "SAS ESP Network Security Groups"
  type        = any
  default     = {}
}

variable "sas_esp_dns" {
  description = "SAS ESP DNS Zones"
  type        = any
  default     = {}
}

#
# AKS 
#

variable "sas_esp_aks" {
  description = "SAS ESP AKS Cluster"
  type        = any
  default     = {}
}

variable "sas_esp_aks_identity" {
  description = "SAS ESP AKS Cluster identity"
  type        = any
  default     = {}
}

variable "sas_esp_aks_private_endpoint" {
  description = "SAS ESP AKS Cluster Private Endpoint"
  type        = any
  default     = {}
}

#
# ACR
#

variable "sas_esp_acr" {
  description = "SAS ESP Azure Container Registry"
  type        = any
  default     = {}
}

variable "sas_esp_acr_identity" {
  description = "SAS ESP Azure Container Registry identity"
  type        = any
  default     = {}
}

#
# Azure Virtual Machine for Bastion
#

variable "sas_esp_vm_bastion" {
  description = "SAS ESP Virtual Machine for Bastion"
  type        = any
  default     = {}
}

variable "sas_esp_vm_bastion_identity" {
  description = "SAS ESP Virtual Machine for Bastion identity"
  type        = any
  default     = {}
}

#
# Azure PostgreSQL
#

variable "sas_esp_postgresql" {
  description = "SAS ESP Azure PostgreSQL"
  type        = any
  default     = {}
}

#
# Azure Serviec Bus
#

variable "sas_esp_servicebus" {
  description = "SAS ESP Azure Service Bus"
  type        = any
  default     = {}
}

#
# Azure NetApp Files
#

variable "sas_esp_anf" {
  description = "SAS ESP Azure NetApp Files"
  type        = any
  default     = {}
}

#
# Azure Files NFS
#

variable "sas_esp_azure_files_nfs" {
  description = "SAS ESP Azure Files NFS"
  type        = any
  default     = {}
}

variable "sas_esp_azure_files_nfs_private_endpoint" {
  description = "SAS ESP Azure Files NFS Private Endpoint"
  type        = any
  default     = {}
}
