#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

common::load_runtime_env

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
