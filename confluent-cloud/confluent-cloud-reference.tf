#
# Input references to other resources
#

variable "reference" {
  description = "Confluent Resource references"
  type = object({
    confluent_environment             = optional(map(any))
    confluent_kafka_cluster           = optional(map(any))
    confluent_schema_registry_cluster = optional(map(any))
    confluent_kafka_topic             = optional(map(any))
  })
  default = {}
}

locals {
  reference_confluent_environment             = coalesce(var.reference.confluent_environment, {})
  reference_confluent_kafka_cluster           = coalesce(var.reference.confluent_kafka_cluster, {})
  reference_confluent_schema_registry_cluster = coalesce(var.reference.confluent_schema_registry_cluster, {})
  reference_confluent_kafka_topic             = coalesce(var.reference.confluent_kafka_topic, {})
}
