#!/usr/bin/env bash
#
# Usage:
#   kubeconfig.sh
#
# Depends on:
#  kubectl
#  scp
#  dig
#
# Based on Bash Boilerplate: https://github.com/xwmx/bash-boilerplate
#
# Copyright (c) 2020 Jamie McDonlad

###############################################################################
# Strict Mode
###############################################################################
set -o nounset
set -o errexit
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR
set -o errtrace
set -o pipefail
IFS=$'\n\t'

###############################################################################
# Environment
###############################################################################

_ME=$(basename "${0}")

_CLUSTER_NAME="qwyck-cloud.co.uk"
_CLUSTER_IP=$(dig +short kube1.${_CLUSTER_NAME})
_CLUSTER_PORT=6443

###############################################################################
# Help
###############################################################################

_print_help() {
  cat <<HEREDOC
Usage:
  ${_ME}
  ${_ME} -h | --help

Options:
  -h --help  Show this screen.
HEREDOC
}

###############################################################################
# Program Functions
###############################################################################

_get_config() {
  [ -d $HOME/.kube/${_CLUSTER_NAME} ] || mkdir -p $HOME/.kube/${_CLUSTER_NAME}
  
  scp -oStrictHostKeyChecking=no \
    root@${_CLUSTER_IP}:/etc/kubernetes/pki/{apiserver-kubelet-client.key,apiserver-kubelet-client.crt,ca.crt} \
    $HOME/.kube/${_CLUSTER_NAME}
  
  kubectl config set-cluster ${_CLUSTER_NAME} \
    --certificate-authority=$HOME/.kube/${_CLUSTER_NAME}/ca.crt \
    --server=https://${_CLUSTER_IP}:${_CLUSTER_PORT} \
    --embed-certs=true
  
  kubectl config set-credentials ${_CLUSTER_NAME}-admin \
    --client-key=$HOME/.kube/${_CLUSTER_NAME}/apiserver-kubelet-client.key \
    --client-certificate=$HOME/.kube/${_CLUSTER_NAME}/apiserver-kubelet-client.crt \
    --embed-certs=true
  
  kubectl config set-context ${_CLUSTER_NAME} \
    --cluster=${_CLUSTER_NAME} \
    --user=${_CLUSTER_NAME}-admin
  
  kubectl config use-context ${_CLUSTER_NAME}
  
  kubectl get nodes
  
  rm -rf $HOME/.kube/${_CLUSTER_NAME}
}

###############################################################################
# Main
###############################################################################

_main() {
  if [[ "${1:-}" =~ ^-h|--help$  ]]
  then
    _print_help
  else
    _get_config "$@"
  fi
}

_main "$@"
