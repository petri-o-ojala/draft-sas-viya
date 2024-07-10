#
# Terraform module outputs
#

output "confluent_kafka_cluster" {
  description = "Confluent Kafka clusters"
  value       = confluent_kafka_cluster.lz
}

output "confluent_kafka_topic" {
  description = "Confluent Kafka topics"
  value       = confluent_kafka_topic.lz
}
