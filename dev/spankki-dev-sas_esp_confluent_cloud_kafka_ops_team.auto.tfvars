#
# SAS ESP Confluent Cloud Kafka OPS Team
#

/*
sas_esp_confluent_cloud_kafka = {
#
# Azure Keyvault credentials
#
  datasource = {
    keyvault = {
      "sas-subscription" = {
        secret = [
          "confluent-cloud-afc-esp-tietoevry-developers"
        ]
      }
    }
  }
  #
  # Confluent Cloud environment
  #
  environment = {
    "sas-esp-dev" = {
      display_name = "Staging"
      stream_governance = {
        package = "ESSENTIALS"
      }
    }
  }
  schema_registry = {
    cluster = {
      "sas-esp-dev" = {
        environment = {
          id = "sas-esp-dev"
        }
      }
    }
  }
  #
  # Kafka Cluster
  #
  kafka = {
    cluster = {
      "sas-esp-basic" = {
        display_name = "inventory"
        availability = "SINGLE_ZONE"
        cloud        = "AZURE"
        region       = "westeurope"
        basic        = {}
        environment = {
          id = "sas-esp-dev"
        }
      }
    }
    topic = {
      "sas-esp-topic1" = {
        kafka_cluster = {
          id = "sas-esp-kafka-dev"
        }
        topic_name = "sas-esp-ops-team-topic1"
        #est_endpoint = "sas-esp-kafka-dev"
        credentials = {
          #TODO: app-manager CLOUD API KEY and SECRET
          key = "Q2O2DF7METRBAMD7"
          secret = "sas-subscription:confluent-cloud-afc-esp-tietoevry-developers"
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
        description  = "Service account to manage 'inventory' Kafka cluster"
      }
      "app-consumer" = {
        display_name = "app-consumer"
        description  = "Service account to consume from 'orders' topic of 'inventory' Kafka cluster"
      }
      "app-producer" = {
        display_name = "app-producer"
        description  = "Service account to produce to 'orders' topic of 'inventory' Kafka cluster"
      }
    }
    #
    # Cluster Admin role for application manager
    #
    role_binding = {
      "app-manager-kafka-cluster-admin" = {
        principal   = "app-manager" # reference to service_account
        role_name   = "CloudClusterAdmin"
        crn_pattern = "kafka-cluster:sas-esp-basic" # reference to Kafka cluster
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
          id          = "kafka-cluster:sas-esp-basic" # reference to Kafka cluster
          api_version = "kafka-cluster:sas-esp-basic"
          kind        = "kafka-cluster:sas-esp-basic"

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
*/
