#
# SAS Viya Azure configuration for Kafka (Confluent Cloud)
#

#
# Naming scheme:
# rg-spankki-afc-esp-<region>-<function>-<environment>

sas_viya_network_private_endpoint = {
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
      resource_group_name = "rg-spankki-afc-esp-we-network-dev"
      location            = "westeurope"
      tags = {
        "terraform"  = "true"
        "managed_by" = "tietoevry"
      }
      subnet_id = "sas-viya-dev_sas-viya-dev-endpoint"
      private_service_connection = {
        name                              = "endpoint-spankki-afc-esp-we-kafka-dev"
        is_manual_connection              = true
        private_connection_resource_alias = "to-be-defined.westeurope.azure.privatelinkservice"
        request_message                   = "Please approve my connection, thanks."
      }
      ip_configuration = [
        {
          name               = "privatelink-kafka-dev"
          private_ip_address = "10.10.2.32"
      }]
    }
  }
}
