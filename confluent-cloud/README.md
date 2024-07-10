<!-- BEGIN_TF_DOCS -->

Confluent Cloud

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | 1.80.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | 1.80.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| confluent_environment.lz | resource |
| confluent_network.lz | resource |
| confluent_network_link_endpoint.lz | resource |
| confluent_network_link_service.lz | resource |
| confluent_private_link_access.lz | resource |
| confluent_private_link_attachment.lz | resource |
| confluent_private_link_attachment_connection.lz | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_confluent"></a> [confluent](#input\_confluent) | Confluent Cloud | <pre>object({<br>    environment = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_environment<br>      display_name = string<br>      stream_governance = optional(object({<br>        package = string<br>      }))<br>    })))<br>    network = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network<br>      display_name     = string<br>      cloud            = string<br>      region           = string<br>      cidr             = optional(string)<br>      reserved_cidr    = optional(string)<br>      connection_types = list(string)<br>      zones            = optional(list(string))<br>      zone_info = optional(list(object({<br>        zone_id = string<br>        cidr    = string<br>      })))<br>      dns_config = optional(object({<br>        resolution = string<br>      }))<br>      environment = optional(object({<br>        id = string<br>      }))<br>    })))<br>    network_link_service = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network_link_service<br>      display_name = optional(string)<br>      description  = optional(string)<br>      environment = optional(object({<br>        id = string<br>      }))<br>      network = object({<br>        id = string<br>      })<br>      accept = optional(object({<br>        environments = optional(list(string))<br>        networks     = optional(list(string))<br>      }))<br>    })))<br>    network_link_endpoint = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network_link_endpoint<br>      display_name = optional(string)<br>      description  = optional(string)<br>      environment = optional(object({<br>        id = string<br>      }))<br>      network = object({<br>        id = string<br>      })<br>      network_link_service = object({<br>        id = string<br>      })<br>    })))<br>    private_link_access = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_access<br>      display_name = string<br>      environment = optional(object({<br>        id = string<br>      }))<br>      network = optional(list(object({<br>        id = string<br>      })))<br>      aws = optional(object({<br>        account = string<br>      }))<br>      azure = optional(object({<br>        subscription = string<br>      }))<br>      gcp = optional(object({<br>        project = string<br>      }))<br>    })))<br>    private_link_attachment = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_attachment<br>      display_name = optional(string)<br>      cloud        = string<br>      region       = string<br>      environment = optional(object({<br>        id = string<br>      }))<br>      connection = optional(map(object({<br>        # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_private_link_attachment_connection<br>        display_name = optional(string)<br>        aws = optional(object({<br>          vpc_endpoint_id = string<br>        }))<br>        azure = optional(object({<br>          private_endpoint_resource_id = string<br>        }))<br>      })))<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Confluent Resource references | <pre>object({<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_environment"></a> [confluent\_environment](#output\_confluent\_environment) | Confluent Environments |
| <a name="output_confluent_network"></a> [confluent\_network](#output\_confluent\_network) | Confluent Cloud Networks |
| <a name="output_confluent_network_link_service"></a> [confluent\_network\_link\_service](#output\_confluent\_network\_link\_service) | Confluent Cloud Network link services |
<!-- END_TF_DOCS -->