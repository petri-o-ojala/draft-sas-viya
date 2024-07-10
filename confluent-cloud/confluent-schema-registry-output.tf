#
# Terraform module outputs
#

output "confluent_schema_registry_cluster" {
  description = "Confluent Schema Registry clusters"
  value       = data.confluent_schema_registry_cluster.lz
}
