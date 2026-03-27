#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

common::load_runtime_env

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
