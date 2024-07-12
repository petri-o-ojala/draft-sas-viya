#
# SAS ESP Confluent Cloud Kafka OPS Team
#

sas_esp_confluent_cloud_kafka = {
  #
  # Confluent Cloud environment
  #
  environment = {
    "sas-esp-dev" = {
      display_name = "Development"
      stream_governance = {
        package = "ESSENTIALS"
      }
    }
  }
  schema_registry = {
    cluster = {
      "sas-esp-standard" = {
        environment = {
          #id = "sas-esp-dev"
          id = "env-7q91oo"
        }
      }
    }
  }
  #
  # Kafka Cluster
  #
  kafka = {
    cluster = {
      "sas-esp-standard" = {
        display_name = "sas-esp-kafka-dev"
        availability = "SINGLE_ZONE"
        cloud        = "AZURE"
        region       = "westeurope"
        standard        = {}
        environment = {
          #id = "sas-esp-dev"
          id = "env-7q91oo"
        }
      }
    }
    topic = {
      "sas-esp-topic1" = {
        kafka_cluster = {
          id = "sas-esp-standard"
        }
        topic_name = "sas-esp-topic1"
        #TODO: rest_endpoint = "kafka_cluster.rest_endpoint"
        credentials = {
          #TODO: app-manager CLOUD API KEY and SECRET
          key = "EWPP3RCOC3QHNBBM"
          secret = "MJXLrRNr7HxSfzOxLKTRTdG5jO5gHzpeJZ4TlutxY+3H/O3eBCSc3X2/mLoWVLIh"
        }
      }
    }
  }
}

sas_esp_confluent_cloud_kafka_ops_team = {
  #
  # IAM for OPS team
  #
  iam = {
    #
    # Service Accounts for application manager, consumer and producer
    #
    service_account = {
      "app-manager" = {
        display_name = "app-manager"
        description  = "Service account to manage 'sas-esp-kafka-dev' Kafka cluster"
      }
      "app-consumer" = {
        display_name = "app-consumer"
        description  = "Service account to consume from 'orders' topic of 'sas-esp-kafka-dev' Kafka cluster"
      }
      "app-producer" = {
        display_name = "app-producer"
        description  = "Service account to produce to 'orders' topic of 'sas-esp-kafka-dev' Kafka cluster"
      }
    }
    #
    # Cluster Admin role for application manager
    #
    role_binding = {
      "app-manager-kafka-cluster-admin" = {
        principal   = "app-manager" # reference to service_account
        role_name   = "CloudClusterAdmin"
        crn_pattern = "kafka-cluster:sas-esp-standard" # reference to Kafka cluster
      }
    }
    #
    # Cloud and Kafka API keys for application manager
    #
    api_key = {
      "app-manager-kafka-api-key" = {
        display_name = "app-manager-kafka-api-key"
        description  = "Kafka API Key that is owned by 'app-manager' service account"

        owner = {
          id          = "app-manager"
          api_version = "app-manager"
          kind        = "app-manager"
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
      "app-manager-cloud-api-key" = {
        display_name = "app-manager-cloud-api-key"
        description  = "Cloud API Key that is owned by 'app-manager' service account"
        owner = {
          id          = "app-manager"
          api_version = "app-manager"
          kind        = "app-manager"
        }
      }
    }
  }
}
