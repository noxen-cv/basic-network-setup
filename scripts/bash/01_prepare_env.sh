#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
ENV_FILE="${1:-$REPO_ROOT/environments/dev/network.env}"

if [[ "$ENV_FILE" != /* ]]; then
  # Accept repo-root-relative paths regardless of current directory.
  if [[ -f "$REPO_ROOT/$ENV_FILE" ]]; then
    ENV_FILE="$REPO_ROOT/$ENV_FILE"
  fi
fi

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

cat > $REPO_ROOT/.network.env.runtime <<EOF
LOCATION="$LOCATION"
RESOURCE_GROUP="$RESOURCE_GROUP"
VNET_NAME="$VNET_NAME"
VNET_ADDRESS_SPACE="$VNET_ADDRESS_SPACE"
FRONTEND_SUBNET_NAME="$FRONTEND_SUBNET_NAME"
FRONTEND_SUBNET_PREFIX="$FRONTEND_SUBNET_PREFIX"
BACKEND_SUBNET_NAME="$BACKEND_SUBNET_NAME"
BACKEND_SUBNET_PREFIX="$BACKEND_SUBNET_PREFIX"
DATABASE_SUBNET_NAME="$DATABASE_SUBNET_NAME"
DATABASE_SUBNET_PREFIX="$DATABASE_SUBNET_PREFIX"
EOF

echo "Prepared runtime variables in .network.env.runtime"
echo "Resource Group: $RESOURCE_GROUP"
echo "Virtual Network: $VNET_NAME"
