#
# SAS ESP Azure configuration for Kafka (Confluent Cloud)
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

/*
sas_esp_network_private_endpoint = {
  #
  # Separate as private endpoints need both network and DNS
  #
  private_endpoint = {
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint
    #
    # Kafka
    #
    "confluent-cloud-kafka" = {
      name                = "endpoint-spankki-afc-esp-we-kafka-dev"
      resource_group_name = "rg-networking"
      location            = "westeurope"
      tags = {
        "application" = "S-Pankki AFC ESP"
        "contact"     = "anssi.yli-leppala@s-pankki.fi"
        "costcenter"  = "3730403"
        "department"  = "S-Pankki"
        "environment" = "dev"
        "terraform"   = "true"
        "managed_by"  = "tietoevry"
      }
      subnet_id = "sas-esp-dev_sas-esp-dev-endpoint"
      private_service_connection = {
        name                              = "psc-spankki-afc-esp-we-kafka-dev"
        is_manual_connection              = true
        private_connection_resource_alias = "s-pglg2-privatelink-3.6ff70e2d-7829-43eb-8027-06c5ef116b19.eastus2.azure.privatelinkservice"
        request_message                   = "Please approve my connection, thanks."
      }
      ip_configuration = [
        {
          name               = "privatelink-kafka-dev"
          private_ip_address = "10.204.71.4"
        }
      ]
      private_dns_zone_group = {
        name = "privatelink-spankki-afc-esp-we-kafka-dev"
        private_dns_zone_ids = [
          "privatelink-confluent-kafka"
        ]
      }
    }
  }
}
*/
