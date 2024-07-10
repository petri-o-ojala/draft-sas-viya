#
# Confluent Cloud Networking
#

locals {
  confluent_network                 = confluent_network.lz
  confluent_private_link_attachment = confluent_private_link_attachment.lz
  confluent_network_link_service    = confluent_network_link_service.lz
}

resource "confluent_network" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network
  for_each = {
    for network in local.confluent_io_network : network.resource_index => network
  }

  display_name     = each.value.display_name
  cloud            = each.value.cloud
  region           = each.value.region
  cidr             = each.value.cidr
  reserved_cidr    = each.value.reserved_cidr
  connection_types = each.value.connection_types
  zones            = each.value.zones

  dynamic "zone_info" {
    for_each = coalesce(each.value.zone_info, [])

    content {
      zone_id = zone_info.value.zone_id
      cidr    = zone_info.value.cidr
    }
  }

  dynamic "dns_config" {
    for_each = try(each.value.dns_config, null) == null ? [] : [1]

    content {
      resolution = each.value.dns_config.resolution
    }
  }

  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }
}

resource "confluent_network_link_service" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network_link_service
  for_each = {
    for service in local.confluent_io_network_link_service : service.resource_index => service
  }

  display_name = each.value.display_name
  description  = each.value.description

  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }

  dynamic "network" {
    for_each = try(each.value.network, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_network, each.value.network.id, null) == null ? each.value.network.id : local.confluent_network[each.value.network.id].id
    }
  }

  dynamic "accept" {
    for_each = try(each.value.accept, null) == null ? [] : [1]

    content {
      environments = each.value.accept.environments
      networks = each.value.accept.networks == null ? null : [
        for id in each.value.accept.networks : lookup(local.confluent_network, id, null) == null ? id : local.confluent_environment[id].id
      ]
    }
  }
}

resource "confluent_network_link_endpoint" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network_link_endpoint
  for_each = {
    for endpoint in local.confluent_io_network_link_endpoint : endpoint.resource_index => endpoint
  }

  display_name = each.value.display_name
  description  = each.value.description

  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }

  dynamic "network" {
    for_each = try(each.value.network, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_network, each.value.network.id, null) == null ? each.value.network.id : local.confluent_network[each.value.network.id].id
    }
  }

  dynamic "network_link_service" {
    for_each = try(each.value.network_link_service, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_network_link_service, each.value.network_link_service.id, null) == null ? each.value.network_link_service.id : local.confluent_network_link_service[each.value.network_link_service.id].id
    }
  }
}

resource "confluent_private_link_access" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_access
  for_each = {
    for access in local.confluent_io_private_link_access : access.resource_index => access
  }

  display_name = each.value.display_name

  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }

  dynamic "network" {
    for_each = coalesce(each.value.network, [])

    content {
      id = lookup(local.confluent_network, network.value.id, null) == null ? network.value.id : local.confluent_network[network.value.id].id
    }
  }

  dynamic "aws" {
    for_each = try(each.value.aws, null) == null ? [] : [1]

    content {
      account = each.value.aws.account
    }
  }

  dynamic "azure" {
    for_each = try(each.value.azure, null) == null ? [] : [1]

    content {
      subscription = each.value.azure.subscription
    }
  }

  dynamic "gcp" {
    for_each = try(each.value.gcp, null) == null ? [] : [1]

    content {
      project = each.value.gcp.project
    }
  }
}

resource "confluent_private_link_attachment" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_access
  for_each = {
    for attachment in local.confluent_io_private_link_attachment : attachment.resource_index => attachment
  }

  display_name = each.value.display_name
  cloud        = each.value.cloud
  region       = each.value.region

  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }
}

resource "confluent_private_link_attachment_connection" "lz" {
  # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_attachment_connection
  for_each = {
    for connection in local.confluent_io_private_link_attachment_connection : connection.resource_index => connection
  }

  display_name = each.value.display_name

  dynamic "environment" {
    for_each = try(each.value.environment, null) == null ? [] : [1]

    content {
      id = lookup(local.confluent_environment, each.value.environment.id, null) == null ? each.value.environment.id : local.confluent_environment[each.value.environment.id].id
    }
  }

  dynamic "private_link_attachment" {
    for_each = try(each.value.private_link_attachment, null) == null ? [] : [1]

    content {
      id = each.value.private_link_attachment.id
    }
  }

  dynamic "aws" {
    for_each = try(each.value.aws, null) == null ? [] : [1]

    content {
      vpc_endpoint_id = each.value.aws.vpc_endpoint_id
    }
  }

  dynamic "azure" {
    for_each = try(each.value.azure, null) == null ? [] : [1]

    content {
      private_endpoint_resource_id = each.value.azure.private_endpoint_resource_id
    }
  }
}
