#
# Confluent Cloud
#

variable "confluent" {
  description = "Confluent Cloud"
  type = object({
    environment = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_environment
      display_name = string
      stream_governance = optional(object({
        package = string
      }))
    })))
    service_account = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_service_account
    })))
    role_binding = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_role_binding
    })))
    api_key = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_api_key
    })))
    network = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network
      display_name     = string
      cloud            = string
      region           = string
      cidr             = optional(string)
      reserved_cidr    = optional(string)
      connection_types = list(string)
      zones            = optional(list(string))
      zone_info = optional(list(object({
        zone_id = string
        cidr    = string
      })))
      dns_config = optional(object({
        resolution = string
      }))
      environment = optional(object({
        id = string
      }))
    })))
    network_link_service = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network_link_service
      display_name = optional(string)
      description  = optional(string)
      environment = optional(object({
        id = string
      }))
      network = object({
        id = string
      })
      accept = optional(object({
        environments = optional(list(string))
        networks     = optional(list(string))
      }))
    })))
    network_link_endpoint = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network_link_endpoint
      display_name = optional(string)
      description  = optional(string)
      environment = optional(object({
        id = string
      }))
      network = object({
        id = string
      })
      network_link_service = object({
        id = string
      })
    })))
    private_link_access = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_access
      display_name = string
      environment = optional(object({
        id = string
      }))
      network = optional(list(object({
        id = string
      })))
      aws = optional(object({
        account = string
      }))
      azure = optional(object({
        subscription = string
      }))
      gcp = optional(object({
        project = string
      }))
    })))
    private_link_attachment = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_attachment
      display_name = optional(string)
      cloud        = string
      region       = string
      environment = optional(object({
        id = string
      }))
      connection = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_attachment_connection
        display_name = optional(string)
        aws = optional(object({
          vpc_endpoint_id = string
        }))
        azure = optional(object({
          private_endpoint_resource_id = string
        }))
      })))
    })))
  })
  default = {}
}

locals {
  #
  # Confluent Environments
  #
  confluent_io_environment = flatten([
    for environment_id, environment in coalesce(try(var.confluent.environment, null), {}) : merge(
      environment,
      {
        resource_index = join("_", [environment_id])
      }
    )
  ])

  #
  # Confluent Networking
  #
  confluent_io_network = flatten([
    for network_id, network in coalesce(try(var.confluent.network, null), {}) : merge(
      network,
      {
        resource_index = join("_", [network_id])
      }
    )
  ])

  confluent_io_network_link_service = flatten([
    for service_id, service in coalesce(try(var.confluent.network_link_service, null), {}) : merge(
      service,
      {
        resource_index = join("_", [service_id])
      }
    )
  ])

  confluent_io_network_link_endpoint = flatten([
    for endpoint_id, endpoint in coalesce(try(var.confluent.network_link_endpoint, null), {}) : merge(
      endpoint,
      {
        resource_index = join("_", [endpoint_id])
      }
    )
  ])

  confluent_io_private_link_access = flatten([
    for access_id, access in coalesce(try(var.confluent.private_link_access, null), {}) : merge(
      access,
      {
        resource_index = join("_", [access_id])
      }
    )
  ])

  confluent_io_private_link_attachment = flatten([
    for attachment_id, attachment in coalesce(try(var.confluent.private_link_attachment, null), {}) : merge(
      attachment,
      {
        resource_index = join("_", [attachment_id])
      }
    )
  ])

  confluent_io_private_link_attachment_connection = flatten([
    for attachment_id, attachment in coalesce(try(var.confluent.private_link_attachment, null), {}) : [
      for connection_id, connection in coalesce(attachment.connection, {}) : merge(
        connection,
        {
          environment = attachment.environment
          private_link_attachment = {
            id = local.confluent_private_link_attachment[attachment_id].id
          }
          resource_index = join("_", [attachment_id, connection_id])
        }
      )
    ]
  ])
}
