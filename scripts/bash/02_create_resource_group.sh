#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .network.env.runtime ]]; then
  echo "Missing .network.env.runtime. Run scripts/bash/01_prepare_env.sh first."
  exit 1
fi

# shellcheck disable=SC1091
source .network.env.runtime

az group create \
  --name "$RESOURCE_GROUP" \
  --location "$LOCATION" \
  --tags purpose=recipe environment=demo tier=networking \
  --output table

echo "Resource group created: $RESOURCE_GROUP"
