#!/usr/bin/env bash
set -euo pipefail

if [[ ! -f .network.env.runtime ]]; then
  echo "Missing .network.env.runtime. Nothing to clean."
  exit 1
fi

# shellcheck disable=SC1091
source .network.env.runtime

az group delete --name "$RESOURCE_GROUP" --yes --no-wait
rm -f .network.env.runtime

echo "Cleanup started for resource group: $RESOURCE_GROUP"
