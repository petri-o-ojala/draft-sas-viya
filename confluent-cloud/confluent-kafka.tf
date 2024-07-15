#
# Confluent Kafka
#

locals {
  confluent_kafka_cluster = merge(
    confluent_kafka_cluster.lz,
    local.reference_confluent_kafka_cluster
  )
  confluent_kafka_topic = merge(
    confluent_kafka_topic.lz,
    local.reference_confluent_kafka_topic
  )
}

resource "confluent_kafka_cluster" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_cluster
  for_each = {
    for cluster in local.confluent_io_kafka_cluster : cluster.resource_index => cluster
  }

  display_name = each.value.display_name
  availability = each.value.availability
  cloud        = each.value.cloud
  region       = each.value.region

  dynamic "basic" {
    for_each = try(each.value.basic, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "standard" {
    for_each = try(each.value.standard, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "enterprise" {
    for_each = try(each.value.enterprise, null) == null ? [] : [1]

    content {
    }
  }

  dynamic "dedicated" {
    for_each = try(each.value.dedicated, null) == null ? [] : [1]

    content {
      cku = each.value.dedicated.cku
    }
  }

  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }

  dynamic "network" {
    for_each = try(each.value.network, null) == null ? [] : [1]

    content {
      id = each.value.network.id
    }
  }

  dynamic "byok_key" {
    for_each = try(each.value.byok_key, null) == null ? [] : [1]

    content {
      id = each.value.byok_key.id
    }
  }

  depends_on = [
    confluent_kafka_cluster.lz
  ]
}

resource "confluent_kafka_cluster_config" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_cluster_config
  for_each = {
    for cluster in local.confluent_io_kafka_cluster_config : cluster.resource_index => cluster
  }

  dynamic "kafka_cluster" {
    for_each = try(each.value.kafka_cluster, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_kafka_cluster, each.value.kafka_cluster.id, null) == null ? each.value.kafka_cluster.id : local.confluent_kafka_cluster[each.value.kafka_cluster.id].id
    }
  }

  rest_endpoint = each.value.rest_endpoint
  config        = each.value.config

  dynamic "credentials" {
    for_each = try(each.value.credentials, null) == null ? [] : [1]

    content {
      key    = each.value.credentials.key == null ? null : lookup(local.azurerm_key_vault_secret, each.value.credentials.key, null) == null ? each.value.credentials.key : data.azurerm_key_vault_secret.lz[each.value.credentials.key].value
      secret = each.value.credentials.secret == null ? null : lookup(local.azurerm_key_vault_secret, each.value.credentials.secret, null) == null ? each.value.credentials.secret : data.azurerm_key_vault_secret.lz[each.value.credentials.secret].value
    }
  }

  depends_on = [
    confluent_kafka_cluster.lz
  ]
}

resource "confluent_kafka_topic" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_topic
  for_each = {
    for topic in local.confluent_io_kafka_topic : topic.resource_index => topic
  }

  dynamic "kafka_cluster" {
    for_each = try(each.value.kafka_cluster, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_kafka_cluster, each.value.kafka_cluster.id, null) == null ? each.value.kafka_cluster.id : local.confluent_kafka_cluster[each.value.kafka_cluster.id].id
    }
  }

  topic_name       = each.value.topic_name
  rest_endpoint    = lookup(local.confluent_kafka_cluster, each.value.rest_endpoint, null) == null ? each.value.rest_endpoint : local.confluent_kafka_cluster[each.value.rest_endpoint].rest_endpoint
  partitions_count = each.value.partitions_count
  config           = each.value.config

  dynamic "credentials" {
    for_each = try(each.value.credentials, null) == null ? [] : [1]

    content {
      key    = each.value.credentials.key == null ? null : lookup(local.azurerm_key_vault_secret, each.value.credentials.key, null) == null ? each.value.credentials.key : data.azurerm_key_vault_secret.lz[each.value.credentials.key].value
      secret = each.value.credentials.secret == null ? null : lookup(local.azurerm_key_vault_secret, each.value.credentials.secret, null) == null ? each.value.credentials.secret : data.azurerm_key_vault_secret.lz[each.value.credentials.secret].value
    }
  }

  depends_on = [
    confluent_kafka_cluster.lz
  ]
}

