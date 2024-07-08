# Status of DEV deployment

Container ``created in existing `sttfstatefyafu3r08k` storage account for SAS ESP's Terraform state file(s).  Versioning enabled for the storage account.

Manually allowed access from `88.114.194.49` to the storage account temporarily.  This IP may have access to other resources as well temporarily.

Azure NetApp Files provider has been enabled on the Azure subscription (`az provider register --namespace Microsoft.NetApp`).

# Supported Azure serviecs

- Resource Groups
- User-managed Identities
- Azure Vnets and Subnets
- Azure Network Security Groups and rules
- Azure Log Analytics Workspace
- Azure DNS
- Privatelink and private endpoints
- Azure Container Registry
- Azure Service Bus
- Azure Database for PostgreSQL (Flexible)
- Azure NetApp Files
- Azure Files NFS
- Azure Kubernetes Service

The terraform modules used may support other resources as well within the Azure service context.

# Deployment components

## Resource Groups

Existing `shared`, `networking` and `ade-keys` resource groups imported to Terraform configuration (for reference purposes and drift detection).

New resource groups created for SAS ESP (as needed), e.g. identity (for user-managed identities used by resources), AKS, ACR, Azure NetApp Files, ServiceBus.

## Networking

Basic VNet resource and AKS subnet imported to Terraform configuration.

Service Endpoints for `Microsoft.Storage` and `Microsoft.KeyVault` have been enabled to the AKS subnet.  Subnets for private endpoints, Azure NetApp Files and Azure PostgreSQL have been added.  ANF and PostgreSQL subnets have delegations configured.

## Network Security

Existing `spankki-nsg-afc-dev-we-internal-01` Network Security Group has been imported to the Terraform configuration.  A new rule to allow AKS traffic within the AKS subnet CIDR range has been added.

## Log Analytics Workspace

Log Analytics Workspace has been configured.

## Private DNS

Azure Private DNS zone for `privatelink.blob.core.windows.net` and `postgres.database.azure.com` are configured and linked to the Vnet.  For Kafka endpoint testing `domdevcjpe9570w.eastus2.azure.devel.cpdev.cloud` zone was used.

## Confluent Kafka Privatelink

Privatelink endpoint to Confluent's Kafka has been tested (with example private connection resource alias) with Private DNS zone.  To be deployed properly when the configuration details are known.

## Azure Container Registry

Azure Container Registry configuration with both system-managed and user-managed identity configured.  Public access to ACR disabled, access allowed only from trusted Azure
services and IP range that includes the VNet.

## Azure Service Bus (Message Broker)

Service Bus configuration and deployment tested, not enabled as not enabled in `viya4-iac-azure` by default or in example configurations.

## Azure Database for PostgreSQL flexible server

PostgreSQL Flexible configuration and deployment tested, not enabled as not enabled in `viya4-iac-azure` by default or in example configurations properly.

## Azure NetApp Files

Azure NetApp Files configuration and deployment has been tested with ANF Account, Pool, Volume and Quota rule (unlikely to be needed).  To be deployed properly when the details and requirements have been set.

## Azure Files NFS

Azure Files NFS share configuration and deployment has been tested with private endpoint and private DNS zone.

## Azure Kubernetes Service

Azure Kubernetes Service configuration and deployment has been tested with five node pools (default, cas, compute, stateless and stateful).  AKS cluster has been configured as private cluster and node pools with auto scaling (except for default).  `SystemAssigned` identity is being used as there are currently not enough permissions to use UserAssigned identity for AKS, it requires IAM role assignments to the network resource group (or resources inside it).

## TO BE ADDED

The following modules to be included:

- Support for Azure Virtual Machines
- Add Diagnostic Settings

