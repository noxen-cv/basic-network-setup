#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/lib/common.sh"

if ! command -v az >/dev/null 2>&1; then
  echo "Azure CLI is required. Install it first: https://learn.microsoft.com/cli/azure/install-azure-cli"
  exit 1
fi

az account show >/dev/null 2>&1 || az login

echo "Azure CLI is ready and authenticated."
