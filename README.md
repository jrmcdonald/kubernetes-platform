# Kubernetes Platform Setup ![build](https://github.com/jrmcdonald/terraform-platform/workflows/build/badge.svg)

## Overview

A set of Ansible & Terraform scripts to manage and deploy a Kubernetes platform to [Hetzner Cloud](https://www.hetzner.com/cloud).

## Requirements

* [Terraform](https://www.terraform.io/)
* [Ansible](https://www.ansible.com/)
* [GnuPG](https://gnupg.org/)

## Manual execution

*Note:* you must be keyed to the `.vault-pass` file to execute the `terraform.yaml` playbook.

From the project root:

```shell script
# install roles
ansible-galaxy install -r requirements.yaml

# setup cloud infrastructure
ansible-playbook -i localhost terraform.yaml

# bootstrap nodes & configure kubernetes
ansible-playbook -i localhost site.yaml
```

To tear down the project:

```shell script
ansible-playbook -i localhost terraform.yaml --extra-vars "state=absent"
```