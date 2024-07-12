
#
# SAS ESP Confluent Cloud Kafka Product Team
#

sas_esp_confluent_cloud_kafka = {
  #
  # Kafka Topic
  #
  kafka = {
    topic = {
      "sas-esp-topic1" = {
        kafka_cluster = {
          #id = "sas-esp-standard"
          id = "lkc-mwpm52"
        }
        topic_name = "sas-esp-kafka-dev-topic1"
        #TODO: rest_endpoint
        #rest_endpoint = confluent_kafka_cluster.rest_endpoint
        credentials = {
          # TODO: app-managers API KEY and SECRET
          key = "EWPP3RCOC3QHNBBM"
          secret = "MJXLrRNr7HxSfzOxLKTRTdG5jO5gHzpeJZ4TlutxY+3H/O3eBCSc3X2/mLoWVLIh"
        }
        environment = {
          #TODO: id
          #id = "sas-esp-dev"
          id = "env-7q91oo"
        }
      }
    }
  }

}

#
# SAS ESP Confluent Cloud Kafka Admin Product Team
#

Xsas_esp_confluent_cloud_kafka_admin_product_team = {
  #
  # IAM for OPS team
  #
  iam = {
    #
    # Kafka API keys for app consumer
    #
    api_key = {
      "app-consumer-kafka-api-key" = {
        display_name = "app-consumer-kafka-api-key"
        description  = "Kafka API Key that is owned by 'app-consumer' service account"

        #TODO: how to reference to app-consumer created by Kafka OPS Team
        owner = {
          id          = data.confluent_service_account.app-consumer.id
          api_version = data.confluent_service_account.app-consumer.api_version
          kind        = data.confluent_service_account.app-consumer.kind
        }

        managed_resource = {
          id          = "kafka-cluster:sas-esp-standard" # reference to Kafka cluster
          api_version = "kafka-cluster:sas-esp-standard"
          kind        = "kafka-cluster:sas-esp-standard"

          environment = {
            id = "sas-esp-dev"
          }
        }
      }
    }
  }
}
