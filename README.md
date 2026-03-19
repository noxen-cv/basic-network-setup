# Basic Network Setup (Azure VNet + Subnets)

Standardized repository for foundational Azure networking with:

- One virtual network
- Three subnets (frontend, backend, database)
- Network Security Groups and baseline rules
- Validation and cleanup scripts

## Repository Structure

```
docs/
	architecture/
		basic-network-setup-vnet-subnets.md
	archive/
		transcripts/
environments/
	dev/
		network.env.example
infra/
	bicep/
	terraform/
scripts/
	bash/
		00_prerequisites.sh
		01_prepare_env.sh
		02_create_resource_group.sh
		03_create_vnet_subnets.sh
		04_create_nsgs.sh
		05_associate_nsgs.sh
		90_validate.sh
		99_cleanup.sh
```

## Quick Start

1. Copy environment template:

	 ```bash
	 cp environments/dev/network.env.example environments/dev/network.env
	 ```

2. Run deployment flow:

	 ```bash
	 bash scripts/bash/00_prerequisites.sh
	 bash scripts/bash/01_prepare_env.sh
	 bash scripts/bash/02_create_resource_group.sh
	 bash scripts/bash/03_create_vnet_subnets.sh
	 bash scripts/bash/04_create_nsgs.sh
	 bash scripts/bash/05_associate_nsgs.sh
	 bash scripts/bash/90_validate.sh
	 ```

3. Cleanup resources:

	 ```bash
	 bash scripts/bash/99_cleanup.sh
	 ```

## Security Note

Do not commit terminal transcripts containing local host names, usernames, subscription IDs, or account details.
Use script templates and environment files instead.
