#
# Azure Container Registry
#

variable "container_registry" {
  description = "Azure Container Registry"
  type = object({
    registry = optional(map(object({
      name                = string
      resource_group_name = string
      location            = string
      custom_metadata     = optional(map(string))
      management_lock = optional(object({
        name       = optional(string)
        lock_level = optional(string, "CanNotDelete")
        notes      = optional(string)
      }))
      tags                          = optional(map(string))
      sku                           = string
      admin_enabled                 = optional(bool)
      public_network_access_enabled = optional(bool)
      quarantine_policy_enabled     = optional(bool)
      zone_redundancy_enabled       = optional(bool)
      export_policy_enabled         = optional(bool)
      anonymous_pull_enabled        = optional(bool)
      data_endpoint_enabled         = optional(bool)
      network_rule_bypass_option    = optional(string)
      georeplications = optional(object({
        location                  = string
        regional_endpoint_enabled = optional(bool)
        zone_redundancy_enabled   = optional(bool)
        tags                      = optional(map(string))
      }))
      network_rule_set = optional(object({
        default_action = optional(string)
        ip_rule = optional(list(object({
          action   = string
          ip_range = string

        })))
      }))
      retention_policy = optional(object({
        days    = optional(number)
        enabled = optional(bool)
      }))
      trust_policy = optional(object({
        enabled = optional(bool)
      }))
      identity = optional(object({
        type         = string
        identity_ids = optional(list(string))
      }))
      encryption = optional(object({
        key_vault_key_id   = string
        identity_client_id = string
      }))
      diagnostic_setting = optional(object({
        name                           = optional(string)
        custom_metadata                = optional(map(string))
        eventhub_name                  = optional(string)
        eventhub_authorization_rule_id = optional(string)
        log_analytics_workspace_id     = optional(string)
        storage_account_id             = optional(string)
        log_analytics_destination_type = optional(string)
        partner_solution_id            = optional(string)
        enabled_log = optional(list(object({
          category       = optional(string)
          category_group = optional(string)
          retention_policy = optional(object({
            days    = optional(number)
            enabled = optional(bool)
          }))
        })))
        metric = optional(list(object({
          category = string
          enabled  = optional(bool)
          retention_policy = optional(object({
            days    = optional(number)
            enabled = optional(bool)
          }))
        })))
      }))
      private_endpoint = optional(list(object({
        # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
        name                          = string
        custom_metadata               = optional(map(string))
        resource_group_name           = optional(string)
        location                      = optional(string)
        subnet_id                     = optional(string)
        custom_network_interface_name = optional(string)
        tags                          = optional(map(string))
        private_dns_zone_group = optional(object({
          name                 = string
          custom_metadata      = optional(map(string))
          private_dns_zone_ids = list(string)
        }))
        private_service_connection = optional(object({
          name                              = string
          custom_metadata                   = optional(map(string))
          is_manual_connection              = bool
          private_connection_resource_id    = optional(string)
          private_connection_resource_alias = optional(string)
          subresource_names                 = optional(list(string))
          request_message                   = optional(string)
        }))
        ip_configuration = optional(list(object({
          name               = string
          custom_metadata    = optional(map(string))
          private_ip_address = string
          subresource_name   = optional(string)
          member_name        = optional(string)
        })))
      })))
      iam = optional(list(object({
        name                                   = optional(string)
        role_definition_name                   = optional(string)
        role_definition_id                     = optional(string)
        principal_type                         = optional(string)
        scope                                  = optional(string)
        principal_id                           = list(string)
        condition                              = optional(string)
        condition_version                      = optional(string)
        delegated_managed_identity_resource_id = optional(string)
        description                            = optional(string)
        skip_service_principal_aad_check       = optional(bool)
      })))
      agent_pool = optional(map(object({
        container_registry_name   = optional(string)
        name                      = string
        resource_group_name       = string
        location                  = string
        tags                      = optional(map(string))
        instance_count            = optional(number)
        tier                      = optional(string)
        virtual_network_subnet_id = optional(string)
      })))
    })))
  })
  default = {}
}

locals {
  #
  # Principal IDs
  #
  azure_principal_id = merge(
    local.entra_id_alias,
    {
      for resource_id, principal_id in local.azure_resource_principal_id : resource_id => principal_id
    }
  )

  #
  # Azure Container Registeries
  #
  azure_container_registry = flatten([
    for registry_id, registry in coalesce(try(var.container_registry.registry, null), {}) : merge(
      registry,
      {
        resource_index = join("_", [registry_id])
      }
    )
  ])

  azure_container_registry_private_endpoint = flatten([
    for registry_id, registry in coalesce(try(var.container_registry.registry, null), {}) : [
      for private_endpoint in coalesce(registry.private_endpoint, []) : merge(
        registry,
        {
          private_endpoint = merge(
            private_endpoint,
            {
              name                = private_endpoint.name
              resource_group_name = coalesce(private_endpoint.resource_group_name, registry.resource_group_name)
              location            = private_endpoint.location == null ? registry.location : private_endpoint.location
            }
          )
          container_registry_resource_index = join("_", [registry_id])
          resource_index                    = join("_", [registry_id, coalesce(private_endpoint.private_service_connection.name, "default")])
        }
      )
    ]
    if registry.private_endpoint != null
  ])

  azure_container_registry_role_assignment = flatten([
    for registry_id, registry in coalesce(try(var.container_registry.registry, null), {}) : [
      for iam_id, iam in coalesce(registry.iam, []) : [
        for principal in coalesce(try(iam.principal_id, null), []) : merge(
          iam,
          {
            scope          = local.azurerm_container_registry[registry_id].id
            principal_id   = principal
            resource_index = join("_", [registry_id, coalesce(iam.role_definition_name, iam.role_definition_id), principal])
          }
        )
      ]
    ]
    if registry.iam != null
  ])

  azure_container_registry_agent_pool = flatten([
    for registry_id, registry in coalesce(try(var.container_registry.registry, null), {}) : [
      for agent_pool_id, agent_pool in coalesce(registry.agent_pool, {}) : merge(
        registry,
        {
          container_registry_name = coalesce(agent_pool.container_registry_name, registry.name)
          resource_index          = join("_", [registry_id, agent_pool_id])
        }
      )
    ]
  ])
}
