#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

ENV_FILE="$(common::resolve_env_file "${1:-}")"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "Missing env file: $ENV_FILE"
  echo "Copy $REPO_ROOT/environments/dev/network.env.example to $REPO_ROOT/environments/dev/network.env and edit values."
  exit 1
fi

# shellcheck disable=SC1090
source "$ENV_FILE"

RANDOM_SUFFIX="$(openssl rand -hex 3)"
RESOURCE_GROUP="${RESOURCE_GROUP_PREFIX}-${RANDOM_SUFFIX}"
VNET_NAME="${VNET_NAME_PREFIX}-${RANDOM_SUFFIX}"

common::write_runtime_env

echo "Prepared runtime variables in .network.env.runtime"
echo "Resource Group: $RESOURCE_GROUP"
echo "Virtual Network: $VNET_NAME"
