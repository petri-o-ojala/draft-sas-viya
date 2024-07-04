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
tofu init --backend-config=backend.cfg

#
# Execute Terrafrom plan
#
tofu plan -out=$BUILD_ARTIFACTSTAGINGDIRECTORY/plan.out -input=false
