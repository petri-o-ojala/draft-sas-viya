#
# SAS ESP Confluent Cloud
#

module "sas_esp_confluent_cloud_kafka" {
  source = "./confluent-cloud"

  confluent = var.sas_esp_confluent_cloud_kafka
}

#
# Kafka Ops-team

module "sas_esp_confluent_cloud_kafka_ops_team" {
  source = "./confluent-cloud"

  reference = {
    confluent_environment             = module.sas_esp_confluent_cloud_kafka.confluent_environment
    confluent_kafka_cluster           = module.sas_esp_confluent_cloud_kafka.confluent_kafka_cluster
    confluent_schema_registry_cluster = module.sas_esp_confluent_cloud_kafka.confluent_schema_registry_cluster
  }

  confluent = var.sas_esp_confluent_cloud_kafka_ops_team
}

#
# This output is from the example code, we don't want to do it this way -- need to add a generic terraform output module that can be used
# generate output with terraform templates and input variables.
#
/*
output "resource-ids" {
  value = <<-EOT
  Environment ID:     ${module.sas_esp_confluent_cloud_kafka.confluent_environment["sas-esp-dev"].id}
  Kafka cluster ID:   ${module.sas_esp_confluent_cloud_kafka.confluent_kafka_cluster["sas-esp-basic"].id}

  Service Accounts with CloudClusterAdmin role and their API Keys (API Keys inherit the permissions granted to the owner):
  ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-manager"].display_name}:                     ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-manager"].id}
  ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-manager"].display_name}'s Cloud API Key:     "${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_api_key["app-manager-cloud-api-key"].id}"
  ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-manager"].display_name}'s Cloud API Secret:  "${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_api_key["app-manager-cloud-api-key"].secret}"

  ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-manager"].display_name}'s Kafka API Key:     "${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_api_key["app-manager-kafka-api-key"].id}"
  ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-manager"].display_name}'s Kafka API Secret:  "${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_api_key["app-manager-kafka-api-key"].secret}"

  Service Accounts with no roles assigned:
  ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-consumer"].display_name}:                    ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-consumer"].id}
  ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-producer"].display_name}:                    ${module.sas_esp_confluent_cloud_kafka_ops_team.confluent_service_account["app-producer"].id}

  EOT

  sensitive = true
}
*/

#
# Kafka Admin Product team

module "sas_esp_confluent_cloud_kafka_admin_product_team" {
  source = "./confluent-cloud"

  reference = {
    confluent_environment             = module.sas_esp_confluent_cloud_kafka.confluent_environment
    confluent_kafka_cluster           = module.sas_esp_confluent_cloud_kafka.confluent_kafka_cluster
    confluent_schema_registry_cluster = module.sas_esp_confluent_cloud_kafka.confluent_schema_registry_cluster
  }

  confluent = var.sas_esp_confluent_cloud_kafka_admin_product_team
}
