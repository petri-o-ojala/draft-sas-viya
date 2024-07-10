#
# Confluent Cloud IAM
#

locals {
  confluent_service_account = confluent_service_account.lz
}

resource "confluent_service_account" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_service_account
  for_each = {
    for account in local.confluent_io_service_account : account.resource_index => account
  }

  display_name = each.value.display_name
  description  = each.value.description
}

resource "confluent_role_binding" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_role_binding
  for_each = {
    for binding in local.confluent_io_role_binding : binding.resource_index => binding
  }

  principal   = lookup(local.confluent_service_account, each.value.principal, null) == null ? each.value.principal : "User:${local.confluent_service_account[each.value.principal].id}"
  role_name   = each.value.role_name
  crn_pattern = each.value.crn_pattern

  depends_on = [
    confluent_service_account.lz,
    confluent_kafka_cluster.lz
  ]
}

resource "confluent_api_key" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_api_key
  for_each = {
    for key in local.confluent_io_api_key : key.resource_index => key
  }

  display_name           = each.value.display_name
  description            = each.value.description
  disable_wait_for_ready = each.value.disable_wait_for_ready

  dynamic "owner" {
    for_each = try(each.value.owner, null) == null ? [] : [1]

    content {
      id          = lookup(local.confluent_service_account, each.value.owner.id, null) == null ? each.value.owner.id : local.confluent_service_account[each.value.owner.id].id
      api_version = lookup(local.confluent_service_account, each.value.owner.api_version, null) == null ? each.value.owner.api_version : local.confluent_service_account[each.value.owner.api_version].api_version
      kind        = lookup(local.confluent_service_account, each.value.owner.kind, null) == null ? each.value.owner.kind : local.confluent_service_account[each.value.owner.kind].kind
    }
  }

  dynamic "managed_resource" {
    for_each = try(each.value.managed_resource, null) == null ? [] : [1]

    content {
      id          = each.value.managed_resource.id
      api_version = each.value.managed_resource.api_version
      kind        = each.value.managed_resource.kind

      dynamic "environment" {
        for_each = try(each.value.managed_resource.environment, null) == null ? [] : [1]

        content {
          id = lookup(local.confluent_environment, each.value.managed_resource.environment.id, null) == null ? each.value.managed_resource.environment.id : local.confluent_environment[each.value.managed_resource.environment.id].id
        }
      }
    }
  }

  depends_on = [
    confluent_role_binding.lz
  ]
}
