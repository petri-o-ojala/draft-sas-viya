#
# Confluent Cloud configuration
#

sas_esp_confluent_cloud = {
  network = {
    "sas-esp-dev" = {
      display_name = "SAS ESP DEV Privatelink"
      cloud        = "AZURE"
      region       = "westeurope"
      connection_types = [
        "PRIVATELINK"
      ]
      environment = {
        id = "conflu-1"
      }
    }
  }
  #
  # Confluent Cloud -- Azure Privatelink for Kafka
  private_link_access = {
    "sas-esp-dev" = {
      display_name = "SAS ESP DEV Privatelink"
      azure = {
        subscription = "4b8befc9-7476-4b49-9e41-75dcd76f343a"
      }
      network = [
        {
          id = "sas-esp-dev"
        }
      ]
      environment = {
        id = "conflu-1"
      }
    }
  }
  private_link_attachment = {
    "sas-esp-dev" = {
      display_name = "SAS ESP DEV Privatelink"
      cloud        = "AZURE"
      region       = "westeurope"
      environment = {
        id = "conflu-1"
      }
    }
  }
  private_link_attachment_connection = {
    "sas-esp-dev" = {
      display_name = "SAS ESP DEV Privatelink"
      azure = {
        private_endpoint_resource_id = "/subscriptions/4b8befc9-7476-4b49-9e41-75dcd76f343a/resourceGroups/testvpc/providers/Microsoft.Network/privateEndpoints/pe-platt-abcdef-az1"
      }
      private_link_attachment = {
        id = "sas-esp-dev"
      }
    }
  }
}

sas_esp_confluent_cloud_kafka = {
  #
  # Kafka cluster and topic configuration
  cluster = {
    "sas-esp-dev" = {
      display_name = "sas-esp-dev"
      availability = "MULTI_ZONE"
      cloud        = "AZURE"
      region       = "westeurope"
      dedicated = {
        cku = 2
      }
      environment = {
        id = "conflu-1"
      }
    }
  }
  topic = {
    "sas-esp-dev-common" = {
      kafka_cluster = {
        id = "sas-esp-dev"
      }
      topic_name       = "common"
      partitions_count = 2
    }
  }
}
