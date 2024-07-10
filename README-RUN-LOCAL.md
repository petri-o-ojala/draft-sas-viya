# Run terraform locally

## Prerequisites

Install OpenTofu client (e.g. 1.7.0) and `git` clients.

## Clone repository

````
ojala@Petri-MacbookPro test % git clone git@github.com:petri-o-ojala/draft-sas-viya.git
Cloning into 'draft-sas-viya'...
remote: Enumerating objects: 329, done.
remote: Counting objects: 100% (329/329), done.
remote: Compressing objects: 100% (207/207), done.
remote: Total 329 (delta 167), reused 266 (delta 106), pack-reused 0
Receiving objects: 100% (329/329), 142.35 KiB | 779.00 KiB/s, done.
Resolving deltas: 100% (167/167), done.
ojala@Petri-MacbookPro test % cd draft-sas-viya
````

## Link DEV configuration files

The pipeline would usually do this step to build a `run` directory that includes the code, modules, and configuration files.  Symlink is preferred so that if
one modifies the files locally, they will be modified in the `dev/` sub-directory automatically.

````
ojala@Petri-MacbookPro draft-sas-viya % for x in dev/*; do
for> ln -s $x
for> done
````

## Set Azure credentials for the Service Principal

````
ojala@Petri-MacbookPro draft-sas-viya % export ARM_CLIENT_ID=4b8c5085-ca25-4922-9c71-2726bf502209
ojala@Petri-MacbookPro draft-sas-viya % export ARM_SUBSCRIPTION_ID=4b8befc9-7476-4b49-9e41-75dcd76f343a
ojala@Petri-MacbookPro draft-sas-viya % export ARM_CLIENT_SECRET="check-from-keyvault"
ojala@Petri-MacbookPro draft-sas-viya % export ARM_TENANT_ID=a652adc3-7bb3-4312-8eb0-6ab323f7d6cd
````

## Initialise terraform

````
ojala@Petri-MacbookPro draft-sas-viya % tofu init --backend-config=backend.cfg

Initializing the backend...

Successfully configured the backend "azurerm"! OpenTofu will automatically
use this backend unless the backend configuration changes.
Initializing modules...
- sas_esp_acr in azure-container-registry
- sas_esp_acr_identity in azure-authorization
- sas_esp_aks in azure-kubernetes-service
- sas_esp_aks_identity in azure-authorization
- sas_esp_aks_private_endpoint in azure-network
- sas_esp_anf in azure-netapp-files
- sas_esp_azure_files_nfs in azure-storage
- sas_esp_azure_files_nfs_private_endpoint in azure-network
- sas_esp_confluent_cloud_kafka in confluent-cloud
- sas_esp_confluent_cloud_kafka_admin_product_team in confluent-cloud
- sas_esp_confluent_cloud_kafka_ops_team in confluent-cloud
- sas_esp_dns in azure-dns
- sas_esp_log_analytics in azure-log-analytics
- sas_esp_network in azure-network
- sas_esp_network_private_endpoint in azure-network
- sas_esp_network_security_group in azure-network-security-group
- sas_esp_postgresql in azure-database
- sas_esp_resource_group in azure-resource-group
- sas_esp_servicebus in azure-messaging
- sas_esp_terraform_identity in azure-authorization
- sas_esp_terraform_keyvault in azure-keyvault
- sas_esp_terraform_resource_group in azure-resource-group
- sas_esp_terraform_state_storage in azure-storage
- sas_esp_vm_bastion in azure-virtual-machine
- sas_esp_vm_bastion_identity in azure-authorization

Initializing provider plugins...
- Finding latest version of hashicorp/random...
- Finding hashicorp/azurerm versions matching "~> 3.110"...
- Finding cloudposse/template versions matching "2.2.0"...
- Finding registry.terraform.io/confluentinc/confluent versions matching "1.80.0"...
- Installing hashicorp/random v3.6.2...
- Installed hashicorp/random v3.6.2 (signed, key ID 0C0AF313E5FD9F80)
- Installing hashicorp/azurerm v3.111.0...
- Installed hashicorp/azurerm v3.111.0 (signed, key ID 0C0AF313E5FD9F80)
- Installing cloudposse/template v2.2.0...
- Installed cloudposse/template v2.2.0 (signed, key ID 7B22D099488F3D11)
- Installing registry.terraform.io/confluentinc/confluent v1.80.0...
- Installed registry.terraform.io/confluentinc/confluent v1.80.0 (signed, key ID 5186AD92BC23B670)

Providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://opentofu.org/docs/cli/plugins/signing/

OpenTofu has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that OpenTofu can guarantee to make the same selections by default when
you run "tofu init" in the future.

OpenTofu has been successfully initialized!

You may now begin working with OpenTofu. Try running "tofu plan" to see
any changes that are required for your infrastructure. All OpenTofu commands
should now work.

If you ever set or change modules or backend configuration for OpenTofu,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
````

## Run terraform plan

Run `tofu plan` to see that everything is properly configured and ready to be used.

````
ojala@Petri-MacbookPro draft-sas-viya % tofu plan
data.azurerm_subscription.customer: Reading...
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-acr"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-acr-dev]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-identity"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-identity-dev]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-network"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-anf"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-anf-dev]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-servicebus"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-servicebus-dev]
module.sas_esp_terraform_resource_group.azurerm_resource_group.lz["terraform"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-terraform-dev]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-postgresql"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-postgresql-dev]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-common"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-common-dev]
module.sas_esp_aks_identity.azurerm_user_assigned_identity.lz["sas-esp"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-identity-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-spankki-afc-esp-we-aks-dev]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-shared"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-shared-prod]
module.sas_esp_resource_group.azurerm_resource_group.lz["sas-esp-aks"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-aks-dev]
module.sas_esp_log_analytics.azurerm_log_analytics_workspace.lz["logs"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-shared-prod/providers/Microsoft.OperationalInsights/workspaces/law-spankki-afc-esp-dev]
data.azurerm_client_config.customer: Reading...
data.azurerm_client_config.customer: Read complete after 0s [id=Y2xpZW50Q29uZmlncy9jbGllbnRJZD00YjhjNTA4NS1jYTI1LTQ5MjItOWM3MS0yNzI2YmY1MDIyMDk7b2JqZWN0SWQ9MDg5NGI5YTItZmMzZS00N2NlLTkwYWYtYmY4NWQwNjg4NjA4O3N1YnNjcmlwdGlvbklkPTRiOGJlZmM5LTc0NzYtNGI0OS05ZTQxLTc1ZGNkNzZmMzQzYTt0ZW5hbnRJZD1hNjUyYWRjMy03YmIzLTQzMTItOGViMC02YWIzMjNmN2Q2Y2Q=]
module.sas_esp_network_security_group.azurerm_network_security_group.lz["sas-esp-aks"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/networkSecurityGroups/spankki-nsg-afc-dev-we-internal-01]
module.sas_esp_acr_identity.azurerm_user_assigned_identity.lz["sas-esp"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-identity-dev/providers/Microsoft.ManagedIdentity/userAssignedIdentities/identity-spankki-afc-esp-we-acr-dev]
data.azurerm_subscription.customer: Read complete after 0s [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a]
module.sas_esp_terraform_state_storage.azurerm_storage_account.lz["terraform-state"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-terraform-dev/providers/Microsoft.Storage/storageAccounts/tfspankkisasespdev]
module.sas_esp_network_security_group.azurerm_network_security_rule.lz["DenyLocalVirtualNetwork"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/networkSecurityGroups/spankki-nsg-afc-dev-we-internal-01/securityRules/DenyLocalVirtualNetwork]
module.sas_esp_network_security_group.azurerm_network_security_rule.lz["AllowLocalAKS"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/networkSecurityGroups/spankki-nsg-afc-dev-we-internal-01/securityRules/AllowLocalAKS]
module.sas_esp_acr.azurerm_container_registry.lz["sas-esp"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-spankki-afc-esp-we-acr-dev/providers/Microsoft.ContainerRegistry/registries/spankkisasdev]
module.sas_esp_network.azurerm_virtual_network.lz["sas-esp-dev"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/virtualNetworks/spankki-vnet-afc-dev-we-internal-01]
module.sas_esp_aks_identity.azurerm_role_assignment.user_assigned_identity["sas-esp_Network Contributor"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/virtualNetworks/spankki-vnet-afc-dev-we-internal-01/providers/Microsoft.Authorization/roleAssignments/07bf5ef0-80b2-a177-a575-55271480ff72]
module.sas_esp_aks_identity.azurerm_role_assignment.user_assigned_identity["sas-esp_Private DNS Zone Contributor"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.westeurope.azmk8s.io/providers/Microsoft.Authorization/roleAssignments/b61671f3-107b-3893-312f-7bfe3a2ae88c]
module.sas_esp_network.azurerm_subnet.lz["sas-esp-dev_sas-esp-dev-aks"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/virtualNetworks/spankki-vnet-afc-dev-we-internal-01/subnets/spankki-subnet-afc-esp-we-aks-dev-01]
module.sas_esp_network.azurerm_subnet.lz["sas-esp-dev_sas-esp-dev-endpoint"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/virtualNetworks/spankki-vnet-afc-dev-we-internal-01/subnets/snet-spankki-afc-esp-we-endpoint-dev-01]
module.sas_esp_network.azurerm_subnet.lz["sas-esp-dev_sas-esp-dev-postgresql"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/virtualNetworks/spankki-vnet-afc-dev-we-internal-01/subnets/snet-spankki-afc-esp-we-postgresql-dev-01]
module.sas_esp_network.azurerm_subnet.lz["sas-esp-dev_sas-esp-dev-anf"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/virtualNetworks/spankki-vnet-afc-dev-we-internal-01/subnets/snet-spankki-afc-esp-we-anf-dev-01]
module.sas_esp_dns.azurerm_private_dns_zone.lz["privatelink-confluent-kafka"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/domdevcjpe9570w.eastus2.azure.devel.cpdev.cloud]
module.sas_esp_dns.azurerm_private_dns_zone.lz["privatelink-file"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net]
module.sas_esp_dns.azurerm_private_dns_zone.lz["privatelink-aks"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.westeurope.azmk8s.io]
module.sas_esp_dns.azurerm_private_dns_zone.lz["privatelink-postgresql"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com]
module.sas_esp_dns.azurerm_private_dns_zone.lz["privatelink-blob"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net]
module.sas_esp_dns.azurerm_private_dns_zone_virtual_network_link.lz["privatelink-postgresql"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.postgres.database.azure.com/virtualNetworkLinks/sas-esp]
module.sas_esp_dns.azurerm_private_dns_zone_virtual_network_link.lz["privatelink-aks"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.westeurope.azmk8s.io/virtualNetworkLinks/sas-esp]
module.sas_esp_dns.azurerm_private_dns_zone_virtual_network_link.lz["privatelink-blob"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net/virtualNetworkLinks/sas-esp]
module.sas_esp_dns.azurerm_private_dns_zone_virtual_network_link.lz["privatelink-file"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net/virtualNetworkLinks/sas-esp]
module.sas_esp_dns.azurerm_private_dns_zone_virtual_network_link.lz["privatelink-confluent-kafka"]: Refreshing state... [id=/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/rg-networking/providers/Microsoft.Network/privateDnsZones/domdevcjpe9570w.eastus2.azure.devel.cpdev.cloud/virtualNetworkLinks/sas-esp]
module.sas_esp_terraform_state_storage.azurerm_storage_container.lz["terraform-state_tf-state-sas-esp-dev"]: Refreshing state... [id=https://tfspankkisasespdev.blob.core.windows.net/tf-state-sas-esp-dev]

No changes. Your infrastructure matches the configuration.

OpenTofu has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
╷
│ Warning: Value for undeclared variable
│
│ The root module does not declare a variable named "Xsas_esp_confluent_cloud_kafka" but a value was found in file
│ "spankki-dev-sas_esp_confluent_cloud_kafka_ops_team.auto.tfvars". If you meant to use this value, add a "variable" block to the configuration.
│
│ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all configurations in your organization. To reduce the
│ verbosity of these warnings, use the -compact-warnings option.
╵
╷
│ Warning: Value for undeclared variable
│
│ The root module does not declare a variable named "Xsas_esp_confluent_cloud_kafka_ops_team" but a value was found in file
│ "spankki-dev-sas_esp_confluent_cloud_kafka_ops_team.auto.tfvars". If you meant to use this value, add a "variable" block to the configuration.
│
│ To silence these warnings, use TF_VAR_... environment variables to provide certain "global" settings to all configurations in your organization. To reduce the
│ verbosity of these warnings, use the -compact-warnings option.
╵
````

## Versions

Versions for reference:

````
ojala@Petri-MacbookPro draft-sas-viya % tofu version
OpenTofu v1.7.0
on darwin_arm64
+ provider registry.opentofu.org/cloudposse/template v2.2.0
+ provider registry.opentofu.org/hashicorp/azurerm v3.111.0
+ provider registry.opentofu.org/hashicorp/random v3.6.2
+ provider registry.terraform.io/confluentinc/confluent v1.80.0
````

