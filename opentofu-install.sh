#!/bin/bash

#
# Settings
#
export TERRAFORM_VERSION=1.5.6
export TERRAFORM_DOWNLOAD_URL=https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#
# We want to fail the script if something exit's with error
set -e
set -o pipefail

#
# Download and unzip terraform to the local directory
#
#wget $TERRAFORM_DOWNLOAD_URL
#unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

#
# Install OpenTofu
#
sudo snap install --classic opentofu
