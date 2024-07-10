#
# SAS ESP Confluent Cloud
#

module "sas_esp_confluent_cloud" {
  source = "./confluent-cloud"

  confluent = var.sas_esp_confluent_cloud
}

module "sas_esp_confluent_cloud_kafka" {
  source = "./confluent-kafka"

  confluent = var.sas_esp_confluent_cloud_kafka
}
