#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .network.env.runtime ]]; then
  echo "Missing .network.env.runtime. Run scripts/bash/01_prepare_env.sh first."
  exit 1
fi

# shellcheck disable=SC1091
source .network.env.runtime

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
