#!/usr/bin/env bash

# shellcheck shell=bash

COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$(cd "$COMMON_DIR/.." && pwd)"
REPO_ROOT="$(cd "$SCRIPTS_DIR/../.." && pwd)"

common::resolve_env_file() {
	local env_file="${1:-$REPO_ROOT/environments/dev/network.env}"

	if [[ "$env_file" != /* && -f "$REPO_ROOT/$env_file" ]]; then
		env_file="$REPO_ROOT/$env_file"
	fi

	printf '%s\n' "$env_file"
}

common::load_runtime_env() {
	local runtime_file="${1:-$REPO_ROOT/.network.env.runtime}"

	if [[ ! -f "$runtime_file" ]]; then
		echo "Missing .network.env.runtime. Run scripts/bash/01_prepare_env.sh first."
		exit 1
	fi

	# shellcheck disable=SC1090
	source "$runtime_file"
}

common::write_runtime_env() {
	local runtime_file="${1:-$REPO_ROOT/.network.env.runtime}"

	cat > "$runtime_file" <<EOF
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
}
