#
# Confluent Cloud
#

variable "confluent" {
  description = "Confluent Cloud"
  type = object({
    #
    # References to Azure Keyvault
    #
    datasource = optional(object({
      keyvault = optional(map(object({
        keyvault_id = optional(string)
        secret      = optional(list(string))
      })))
    }))
    #
    # Confluent Cloud Schema Registry
    #
    schema_registry = optional(object({
      cluster = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_schema_registry_cluster (depreciated)
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/data-sources/confluent_schema_registry_cluster
        /* depreciated
        package = string
        region = object({
          id = string
        })
        */
        # data source
        id           = optional(string)
        display_name = optional(string)
        environment = optional(object({
          id = string
        }))
      })))
      cluster_config = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_schema_registry_cluster_config
      })))
      cluster_mode = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_schema_registry_cluster_mode
      })))
    }))
    kafka = optional(object({
      #
      # Confluent Cloud Kafka
      #
      cluster = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_cluster
        display_name = string
        availability = string
        cloud        = string
        region       = string
        basic = optional(object({
        }))
        standard = optional(object({
        }))
        enterprise = optional(object({
        }))
        dedicated = optional(object({
          cku = string
        }))
        environment = optional(object({
          id = string
        }))
        network = optional(object({
          id = string
        }))
        byok_key = optional(object({
          id = string
        }))
      })))
      cluster_config = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_cluster
        kafka_cluster = optional(object({
          id = string
        }))
        rest_endpoint = optional(string)
        credentials = optional(object({
          key    = string
          secret = string
        }))
        config = optional(map(string))
      })))
      acl = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_acl
      })))
      topic = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_topic
        kafka_cluster = optional(object({
          id = string
        }))
        rest_endpoint = optional(string)
        credentials = optional(object({
          key    = string
          secret = string
        }))
        config           = optional(map(string))
        topic_name       = string
        partitions_count = optional(number)
      })))
    }))
    environment = optional(map(object({
      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_environment
      display_name = string
      stream_governance = optional(object({
        package = string
      }))
    })))
    #
    # Confluent Cloud IAM 
    #
    iam = optional(object({
      service_account = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_service_account
        display_name = string
        description  = optional(string)
      })))
      role_binding = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_role_binding
        principal   = string
        role_name   = string
        crn_pattern = string
      })))
      api_key = optional(map(object({
        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_api_key
        display_name           = string
        description            = optional(string)
        disable_wait_for_ready = optional(bool)
        owner = object({
          id          = string
          api_version = string
          kind        = string
        })
        managed_resource = optional(object({
          id          = string
          api_version = string
          kind        = string
          environment = object({
            id = string
          })
        }))
      })))
    }))
    #
    # Confluent Cloud networking
    #
    network = optional(object({
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
    }))
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
  # Confluent Cloud Kafka
  #

  confluent_io_kafka_cluster = flatten([
    for cluster_id, cluster in coalesce(try(var.confluent.kafka.cluster, null), {}) : merge(
      cluster,
      {
        resource_index = join("_", [cluster_id])
      }
    )
  ])

  confluent_io_kafka_cluster_config = flatten([
    for cluster_config_id, cluster_config in coalesce(try(var.confluent.kafka.cluster_config, null), {}) : merge(
      cluster_config,
      {
        resource_index = join("_", [cluster_config_id])
      }
    )
  ])

  confluent_io_kafka_topic = flatten([
    for topic_id, topic in coalesce(try(var.confluent.kafka.topic, null), {}) : merge(
      topic,
      {
        resource_index = join("_", [topic_id])
      }
    )
  ])

  #
  # Confluent Cloud IAM
  #

  confluent_io_service_account = flatten([
    for account_id, account in coalesce(try(var.confluent.iam.service_account, null), {}) : merge(
      account,
      {
        resource_index = join("_", [account_id])
      }
    )
  ])

  confluent_io_role_binding = flatten([
    for binding_id, binding in coalesce(try(var.confluent.iam.role_binding, null), {}) : merge(
      binding,
      {
        crn_pattern = binding.crn_pattern == null ? null : element(concat(
          [
            startswith(binding.crn_pattern, "kafka-cluster:") ? local.confluent_kafka_cluster[trimprefix(binding.crn_pattern, "kafka-cluster:")].rbac_crn : null
          ],
          [
            # Defaults to the actual value
            binding.crn_pattern
          ]
        ), 0) # We will only use one (first) member of the above, this is just to make the code more readable above
        resource_index = join("_", [binding_id])
      }
    )
  ])

  confluent_io_api_key = flatten([
    for api_key_id, api_key in coalesce(try(var.confluent.iam.api_key, null), {}) : merge(
      api_key,
      {
        managed_resource = api_key.managed_resource == null ? null : {
          id = api_key.managed_resource.id == null ? null : element(concat(
            [
              startswith(api_key.managed_resource.id, "kafka-cluster:") ? local.confluent_kafka_cluster[trimprefix(api_key.managed_resource.id, "kafka-cluster:")].id : null
            ],
            [
              # Defaults to the actual value
              api_key.managed_resource.id
            ]
          ), 0) # We will only use one (first) member of the above, this is just to make the code more readable above
          api_version = api_key.managed_resource.api_version == null ? null : element(concat(
            [
              startswith(api_key.managed_resource.api_version, "kafka-cluster:") ? local.confluent_kafka_cluster[trimprefix(api_key.managed_resource.api_version, "kafka-cluster:")].api_version : null
            ],
            [
              # Defaults to the actual value
              api_key.managed_resource.api_version
            ]
          ), 0) # We will only use one (first) member of the above, this is just to make the code more readable above
          kind = api_key.managed_resource.kind == null ? null : element(concat(
            [
              startswith(api_key.managed_resource.kind, "kafka-cluster:") ? local.confluent_kafka_cluster[trimprefix(api_key.managed_resource.kind, "kafka-cluster:")].kind : null
            ],
            [
              # Defaults to the actual value
              api_key.managed_resource.kind
            ]
          ), 0) # We will only use one (first) member of the above, this is just to make the code more readable above

          environment = api_key.managed_resource.environment
        }
        resource_index = join("_", [api_key_id])
      }
    )
  ])

  #
  # Confluent Schema Registry
  #

  confluent_io_schema_registry_cluster = flatten([
    for cluster_id, cluster in coalesce(try(var.confluent.schema_registry.cluster, null), {}) : merge(
      cluster,
      {
        resource_index = join("_", [cluster_id])
      }
    )
  ])

  #
  # Confluent Networking
  #
  confluent_io_network = flatten([
    for network_id, network in coalesce(try(var.confluent.network.network, null), {}) : merge(
      network,
      {
        resource_index = join("_", [network_id])
      }
    )
  ])

  confluent_io_network_link_service = flatten([
    for service_id, service in coalesce(try(var.confluent.network.network_link_service, null), {}) : merge(
      service,
      {
        resource_index = join("_", [service_id])
      }
    )
  ])

  confluent_io_network_link_endpoint = flatten([
    for endpoint_id, endpoint in coalesce(try(var.confluent.network.network_link_endpoint, null), {}) : merge(
      endpoint,
      {
        resource_index = join("_", [endpoint_id])
      }
    )
  ])

  confluent_io_private_link_access = flatten([
    for access_id, access in coalesce(try(var.confluent.network.private_link_access, null), {}) : merge(
      access,
      {
        resource_index = join("_", [access_id])
      }
    )
  ])

  confluent_io_private_link_attachment = flatten([
    for attachment_id, attachment in coalesce(try(var.confluent.network.private_link_attachment, null), {}) : merge(
      attachment,
      {
        resource_index = join("_", [attachment_id])
      }
    )
  ])

  confluent_io_private_link_attachment_connection = flatten([
    for attachment_id, attachment in coalesce(try(var.confluent.network.private_link_attachment, null), {}) : [
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
