# Kubernetes Platform Setup ![build](https://github.com/jrmcdonald/kubernetes-platform/workflows/build/badge.svg)

## Overview

A set of Ansible & Terraform scripts to manage and deploy a Kubernetes platform to [Hetzner Cloud](https://www.hetzner.com/cloud).

## Requirements

* [Terraform](https://www.terraform.io/)
* [Ansible](https://www.ansible.com/)
* [GnuPG](https://gnupg.org/)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [Helm](https://helm.sh/)

## Manual execution

*Note:* you must be keyed to the `.vault-pass` file to execute the playbooks.

From the project root:

```shell script
# install python libraries
python -m pip install --upgrade pip
pip install -r requirements.txt
pip install -r kubespray/requirements.txt

# install mitogen
ANSIBLE_STRATEGY=linear ansible-playbook mitogen.yaml

# install roles
ansible-galaxy install -r requirements.yaml

# setup cloud infrastructure
ansible-playbook terraform.yaml

# bootstrap nodes & configure kubernetes
ansible-playbook -i production kubernetes.yaml --become
```

To set up local config for an existing cluster:

```shell script
ansible-playbook -i production kubernetes.yaml --become --tags "local" --skip-tags "kubespray"
```

To tear down the project:

```shell script
ansible-playbook -i localhost terraform.yaml --extra-vars "state=absent"
```