#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .network.env.runtime ]]; then
  echo "Missing .network.env.runtime. Run scripts/bash/01_prepare_env.sh first."
  exit 1
fi

# shellcheck disable=SC1091
source .network.env.runtime

az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$FRONTEND_SUBNET_NAME" \
  --network-security-group "nsg-${FRONTEND_SUBNET_NAME}"

az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$BACKEND_SUBNET_NAME" \
  --network-security-group "nsg-${BACKEND_SUBNET_NAME}"

az network vnet subnet update \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$DATABASE_SUBNET_NAME" \
  --network-security-group "nsg-${DATABASE_SUBNET_NAME}"

echo "NSGs associated with subnets."
