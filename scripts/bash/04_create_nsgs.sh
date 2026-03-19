#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .network.env.runtime ]]; then
  echo "Missing .network.env.runtime. Run scripts/bash/01_prepare_env.sh first."
  exit 1
fi

# shellcheck disable=SC1091
source .network.env.runtime

FRONTEND_NSG="nsg-${FRONTEND_SUBNET_NAME}"
BACKEND_NSG="nsg-${BACKEND_SUBNET_NAME}"
DATABASE_NSG="nsg-${DATABASE_SUBNET_NAME}"

az network nsg create --resource-group "$RESOURCE_GROUP" --name "$FRONTEND_NSG" --location "$LOCATION" --tags tier=frontend
az network nsg create --resource-group "$RESOURCE_GROUP" --name "$BACKEND_NSG" --location "$LOCATION" --tags tier=backend
az network nsg create --resource-group "$RESOURCE_GROUP" --name "$DATABASE_NSG" --location "$LOCATION" --tags tier=database

az network nsg rule create \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$FRONTEND_NSG" \
  --name "Allow-HTTP" \
  --protocol tcp \
  --priority 1000 \
  --destination-port-ranges 80 \
  --access allow \
  --direction inbound \
  --source-address-prefixes "*"

az network nsg rule create \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$BACKEND_NSG" \
  --name "Allow-From-Frontend" \
  --protocol tcp \
  --priority 1000 \
  --destination-port-ranges 8080 \
  --access allow \
  --direction inbound \
  --source-address-prefixes "$FRONTEND_SUBNET_PREFIX"

az network nsg rule create \
  --resource-group "$RESOURCE_GROUP" \
  --nsg-name "$DATABASE_NSG" \
  --name "Allow-Database-From-Backend" \
  --protocol tcp \
  --priority 1000 \
  --destination-port-ranges 5432 \
  --access allow \
  --direction inbound \
  --source-address-prefixes "$BACKEND_SUBNET_PREFIX"

echo "NSGs and baseline rules created."
