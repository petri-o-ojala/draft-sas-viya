#
# Confluent Schema Registry
#

locals {
  confluent_schema_registry_cluster = merge(
    data.confluent_schema_registry_cluster.lz,
    local.reference_confluent_schema_registry_cluster
  )
}

data "confluent_schema_registry_cluster" "lz" {
  for_each = {
    for cluster in local.confluent_io_schema_registry_cluster : cluster.resource_index => cluster
  }

  id           = each.value.id
  display_name = each.value.display_name


  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }

  depends_on = [
    confluent_environment.lz
  ]
}

# confluent_schema_registry_cluster resource is depreciated.

