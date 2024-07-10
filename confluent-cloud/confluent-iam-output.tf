#
# Terraform module outputs
#

output "confluent_service_account" {
  description = "Confluent Service accounts"
  value       = confluent_service_account.lz
}

output "confluent_api_key" {
  description = "Confluent API keys"
  value       = confluent_api_key.lz
}
