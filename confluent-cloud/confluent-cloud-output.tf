#
# Terraform module outputs
#

output "confluent_environment" {
  description = "Confluent Environments"
  value       = confluent_environment.lz
}
