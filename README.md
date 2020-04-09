# Kubernetes Platform Setup ![build](https://github.com/jrmcdonald/terraform-platform/workflows/build/badge.svg)

## Overview

A set of Terraform scripts to manage and deploy a Kubernetes platform to [Hetzner Cloud](https://www.hetzner.com/cloud).

## Requirements

* The requirements listed at [hobby-kube/provisioning](https://github.com/hobby-kube/provisioning)
* [GnuPG](https://gnupg.org/)
* [blackbox](https://github.com/StackExchange/blackbox)
* [Helm](https://helm.sh/)

## Manual execution

*Note:* you must be an admin in blackbox to decrypt the secrets file.

From the project root:

```shell script
# decrypt the secrets file
blackbox_decrypt_all_files

# fetch the required modules
terraform init

# see what `terraform apply` will do
terraform plan --var-file=secrets.tfvars.json

# execute it
terraform apply --var-file=secrets.tfvars.json

# shred all secrets
blackbox_shred_all_files
```