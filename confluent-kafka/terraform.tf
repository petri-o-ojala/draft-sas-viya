#
# Terraform version constrains
#

terraform {
  required_providers {
    confluent = {
      # Confluent Cloud
      source  = "registry.terraform.io/confluentinc/confluent"
      version = "1.80.0"
    }
  }
}
