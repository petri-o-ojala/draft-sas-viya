#
# Terraform module outputs
#

output "confluent_network" {
  description = "Confluent Cloud Networks"
  value       = confluent_network.lz
}

output "confluent_network_link_service" {
  description = "Confluent Cloud Network link services"
  value       = confluent_network_link_service.lz
}
