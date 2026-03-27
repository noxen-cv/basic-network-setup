#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

common::load_runtime_env

echo "=== VNet summary ==="
az network vnet show --resource-group "$RESOURCE_GROUP" --name "$VNET_NAME" --output table

echo "=== Subnets ==="
az network vnet subnet list --resource-group "$RESOURCE_GROUP" --vnet-name "$VNET_NAME" --output table

echo "=== NSG associations ==="
for subnet in "$FRONTEND_SUBNET_NAME" "$BACKEND_SUBNET_NAME" "$DATABASE_SUBNET_NAME"; do
  nsg_id=$(az network vnet subnet show \
    --resource-group "$RESOURCE_GROUP" \
    --vnet-name "$VNET_NAME" \
    --name "$subnet" \
    --query "networkSecurityGroup.id" \
    --output tsv)
  echo "$subnet -> $nsg_id"
done
