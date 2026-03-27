#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

if [[ ! -f "$REPO_ROOT/.network.env.runtime" ]]; then
  echo "Missing .network.env.runtime. Nothing to clean."
  exit 1
fi

common::load_runtime_env

az group delete --name "$RESOURCE_GROUP" --yes --no-wait
rm -f "$REPO_ROOT/.network.env.runtime"

echo "Cleanup started for resource group: $RESOURCE_GROUP"
