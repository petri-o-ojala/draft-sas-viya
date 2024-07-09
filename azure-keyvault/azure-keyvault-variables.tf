#
# Azure Key vaults
#

variable "keyvault" {
  description = "Azure Keyvaults"
  type = object({
    secret = optional(map(object({
      name            = string
      custom_metadata = optional(map(string))
      tags            = optional(map(string))
      value           = optional(string)
      key_vault_id    = string
      content_type    = optional(string)
      not_before_date = optional(string)
      expiration_date = optional(string)
      random_password = optional(object({
        length           = optional(number)
        upper            = optional(bool)
        min_upper        = optional(number)
        lower            = optional(bool)
        min_lower        = optional(number)
        numeric          = optional(bool)
        min_numeric      = optional(number)
        special          = optional(bool)
        override_special = optional(string)
        min_special      = optional(number)
      }))
    })))
    vault = optional(map(object({
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault
      name                = string
      custom_metadata     = optional(map(string))
      resource_group_name = string
      location            = optional(string)
      sku_name            = string
      tenant_id           = string
      tags                = optional(map(string))
      management_lock = optional(object({
        name       = optional(string)
        lock_level = optional(string, "CanNotDelete")
        notes      = optional(string)
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
      enabled_for_deployment          = optional(bool)
      enabled_for_disk_encryption     = optional(bool)
      enabled_for_template_deployment = optional(bool)
      enable_rbac_authorization       = optional(bool)
      purge_protection_enabled        = optional(bool)
      public_network_access_enabled   = optional(bool)
      soft_delete_retention_days      = optional(number)
      network_acls = optional(object({
        bypass                     = string
        default_action             = string
        ip_rules                   = optional(list(string))
        virtual_network_subnet_ids = optional(list(string))
      }))
      contact = optional(object({
        email = string
        name  = optional(string)
        phone = optional(string)
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
  # Azure Key Vaults
  #
  azure_key_vault = flatten([
    for vault_id, vault in coalesce(try(var.keyvault.vault, null), {}) : merge(
      vault,
      {
        name = templatestring(vault.name, merge(
          local.common.custom_metadata,
          vault.custom_metadata
        ))
        resource_group_name = templatestring(vault.resource_group_name, merge(
          local.common.custom_metadata,
          vault.custom_metadata
        ))
        resource_index = join("_", [vault_id])
      }
    )
  ])

  #
  # Azure Keyvault Private Endpoints
  #
  azure_key_vault_private_endpoint = flatten([
    for vault_id, vault in coalesce(try(var.keyvault.vault, null), {}) : [
      for private_endpoint in coalesce(vault.private_endpoint, []) : merge(
        vault,
        {
          private_endpoint = merge(
            private_endpoint,
            {
              name = templatestring(private_endpoint.name, merge(
                local.common.custom_metadata,
                vault.custom_metadata,
                private_endpoint.custom_metadata
              ))
              resource_group_name = templatestring(coalesce(private_endpoint.resource_group_name, vault.resource_group_name), merge(
                local.common.custom_metadata,
                vault.custom_metadata,
                private_endpoint.custom_metadata
              ))
              location = private_endpoint.location == null ? vault.location : private_endpoint.location
            }
          )
          keyvault_resource_index = join("_", [vault_id])
          resource_index          = join("_", [vault_id, coalesce(private_endpoint.private_service_connection.name, "default")])
        }
      )
    ]
    if vault.private_endpoint != null
  ])

  azure_key_vault_role_assignment = flatten([
    for vault_id, vault in coalesce(try(var.keyvault.vault, null), {}) : [
      for iam_id, iam in coalesce(vault.iam, []) : [
        for principal in coalesce(try(iam.principal_id, null), []) : merge(
          iam,
          {
            scope          = local.azurerm_key_vault[vault_id].id
            principal_id   = principal
            resource_index = join("_", [vault_id, coalesce(iam.role_definition_name, iam.role_definition_id), principal])
          }
        )
      ]
    ]
    if vault.iam != null
  ])

  #
  # Azure Keyvault Secrets
  #
  azure_key_vault_secret = flatten([
    for secret_id, secret in coalesce(try(var.keyvault.secret, null), {}) : merge(
      secret,
      {
        name = templatestring(secret.name, merge(
          local.common.custom_metadata,
          secret.custom_metadata
        ))
        resource_index = join("_", [secret_id])
      }
    )
  ])

  azure_key_vault_secret_value = flatten([
    for secret_id, secret in coalesce(try(var.keyvault.secret, null), {}) : merge(
      secret,
      {
        resource_index = join("_", [secret_id])
      }
    )
    if secret.random_password != null
  ])
}
