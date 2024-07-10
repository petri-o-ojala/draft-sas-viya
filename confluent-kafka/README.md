<!-- BEGIN_TF_DOCS -->

Confluent Kafka

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
| confluent_kafka_cluster.lz | resource |
| confluent_kafka_cluster_config.lz | resource |
| confluent_kafka_topic.lz | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_confluent"></a> [confluent](#input\_confluent) | Confluent Kafka | <pre>object({<br>    cluster = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_cluster<br>      display_name = string<br>      availability = string<br>      cloud        = string<br>      region       = string<br>      basic = optional(object({<br>      }))<br>      standard = optional(object({<br>      }))<br>      enterprise = optional(object({<br>      }))<br>      dedicated = optional(object({<br>        cku = string<br>      }))<br>      environment = optional(object({<br>        id = string<br>      }))<br>      network = optional(object({<br>        id = string<br>      }))<br>      byok_key = optional(object({<br>        id = string<br>      }))<br>    })))<br>    cluster_config = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_cluster<br>      kafka_cluster = optional(object({<br>        id = string<br>      }))<br>      rest_endpoint = optional(string)<br>      credentials = optional(object({<br>        key    = string<br>        secret = string<br>      }))<br>      config = optional(map(string))<br><br>    })))<br>    topic = optional(map(object({<br>      # https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_kafka_topic<br>      kafka_cluster = optional(object({<br>        id = string<br>      }))<br>      rest_endpoint = optional(string)<br>      credentials = optional(object({<br>        key    = string<br>        secret = string<br>      }))<br>      config           = optional(map(string))<br>      topic_name       = string<br>      partitions_count = optional(number)<br>    })))<br>  })</pre> | `{}` | no |
| <a name="input_reference"></a> [reference](#input\_reference) | Confluent Resource references | <pre>object({<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_confluent_kafka_cluster"></a> [confluent\_kafka\_cluster](#output\_confluent\_kafka\_cluster) | Confluent Kafka clusters |
| <a name="output_confluent_kafka_topic"></a> [confluent\_kafka\_topic](#output\_confluent\_kafka\_topic) | Confluent Kafka topics |
<!-- END_TF_DOCS -->