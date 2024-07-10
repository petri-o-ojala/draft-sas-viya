#
# Confluent Cloud
#

locals {
  confluent_environment = confluent_environment.lz
}

resource "confluent_environment" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_environment
  for_each = {
    for environment in local.confluent_io_environment : environment.resource_index => environment
  }

  display_name = each.value.display_name

  dynamic "stream_governance" {
    for_each = try(each.value.stream_governance, null) == null ? [] : [1]

    content {
      package = each.value.stream_governance.package
    }
  }
}

