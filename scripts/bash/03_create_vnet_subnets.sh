#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .network.env.runtime ]]; then
  echo "Missing .network.env.runtime. Run scripts/bash/01_prepare_env.sh first."
  exit 1
fi

# shellcheck disable=SC1091
source .network.env.runtime

az network vnet create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VNET_NAME" \
  --location "$LOCATION" \
  --address-prefixes "$VNET_ADDRESS_SPACE" \
  --subnet-name "$FRONTEND_SUBNET_NAME" \
  --subnet-prefixes "$FRONTEND_SUBNET_PREFIX" \
  --tags purpose=recipe environment=demo

az network vnet subnet create \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$BACKEND_SUBNET_NAME" \
  --address-prefixes "$BACKEND_SUBNET_PREFIX"

az network vnet subnet create \
  --resource-group "$RESOURCE_GROUP" \
  --vnet-name "$VNET_NAME" \
  --name "$DATABASE_SUBNET_NAME" \
  --address-prefixes "$DATABASE_SUBNET_PREFIX"

echo "VNet and subnets created."
