#!/bin/bash

#
# We want to fail the script if something exit's with error
set -e
set -o pipefail

#
# get credentials from AzureCLI task for Terraform
#
#
# For SPN
#
export ARM_CLIENT_ID=$servicePrincipalId
export ARM_SUBSCRIPTION_ID=$(az account show --query id --output tsv)
#export ARM_CLIENT_SECRET=$servicePrincipalKey
export ARM_TENANT_ID=$tenantId
#
# For Workload Identity
#
export ARM_USE_OIDC=true
export ARM_OIDC_TOKEN=$idToken

#
tofu version

#
# Initialize Terraform with backend configuration
#
tofu init -input=false --backend-config=backend.cfg

#
# Execute Terrafrom show
#
tofu show $PIPELINE_WORKSPACE/plan.out

#
# Save plan as JSON file for utilities
#
tofu show -json $PIPELINE_WORKSPACE/plan.out > $PIPELINE_WORKSPACE/plan.json
