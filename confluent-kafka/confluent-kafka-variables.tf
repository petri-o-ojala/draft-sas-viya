#
# Confluent Kafka
#

variable "confluent" {
  description = "Confluent Kafka"
  type = object({
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
  })
  default = {}
}

locals {
  #
  # Confluent Kafka Clusters
  #
  confluent_io_kafka_cluster = flatten([
    for cluster_id, cluster in coalesce(try(var.confluent.cluster, null), {}) : merge(
      cluster,
      {
        resource_index = join("_", [cluster_id])
      }
    )
  ])

  confluent_io_kafka_cluster_config = flatten([
    for cluster_config_id, cluster_config in coalesce(try(var.confluent.cluster_config, null), {}) : merge(
      cluster_config,
      {
        resource_index = join("_", [cluster_config_id])
      }
    )
  ])

  #
  # Confluent Kafka topics
  #
  confluent_io_kafka_topic = flatten([
    for topic_id, topic in coalesce(try(var.confluent.topic, null), {}) : merge(
      topic,
      {
        resource_index = join("_", [topic_id])
      }
    )
  ])
}
