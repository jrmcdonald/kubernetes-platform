#!/usr/bin/env bash

set -o nounset
set -o errexit
trap 'echo "Aborting due to errexit on line $LINENO. Exit code: $?" >&2' ERR
set -o errtrace
set -o pipefail

IFS=$'\n\t'

METALLB_OUTPUTS=roles/kubernetes/apps/metallb/outputs
INGRESS_NGINX_OUTPUTS=roles/kubernetes/apps/ingress-nginx/outputs
CERT_MANAGER_OUTPUTS=roles/kubernetes/apps/cert-manager/outputs
WEAVE_FLUX_OUTPUTS=roles/kubernetes/apps/weave-flux/outputs

_setup_helm() {
  printf "info: adding helm repositories\n"
  helm repo add stable https://kubernetes-charts.storage.googleapis.com
  helm repo add jetstack https://charts.jetstack.io
  helm repo add fluxcd https://charts.fluxcd.io

  printf "info: updating helm repositories\n"
  helm repo update
}

_install_metallb() {
  printf "info: applying metallb namespace\n"
  kubectl apply -f ${METALLB_OUTPUTS}/00-namespace.yaml

  printf "info: installing/upgrading metallb\n"
  helm upgrade --install --atomic -f ${METALLB_OUTPUTS}/values.yaml metallb stable/metallb --namespace metallb-system
}

_install_nginx_ingress() {
  printf "info: applying ingress-nginx namespace\n"
  kubectl apply -f ${INGRESS_NGINX_OUTPUTS}/00-namespace.yaml

  printf "info: installing/upgrading ingress-nginx\n"
  helm upgrade --install --atomic ingress-nginx stable/nginx-ingress --namespace ingress-nginx
}

_install_certmanager() {
  printf "info: applying cert-manager namespace\n"
  kubectl apply -f ${CERT_MANAGER_OUTPUTS}/00-namespace.yaml

  printf "info: applying cert-manager crd definitions\n"
  kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.14.2/cert-manager.crds.yaml

  printf "info: installing/upgrading cert-manager\n"
  helm upgrade --install --atomic cert-manager jetstack/cert-manager --namespace cert-manager

  printf "info: applying letsencrypt staging issuer\n"
  kubectl apply -f ${CERT_MANAGER_OUTPUTS}/staging-issuer.yaml --namespace cert-manager

  printf "info: applying letsencrypt prod issuer\n"
  kubectl apply -f ${CERT_MANAGER_OUTPUTS}/prod-issuer.yaml --namespace cert-manager
}

_install_weave_flux() {
  printf "info: applying weave flux namespace\n"
  kubectl apply -f ${WEAVE_FLUX_OUTPUTS}/00-namespace.yaml

  printf "info: installing/upgrading fluxcd\n"
  helm upgrade --install --atomic --wait flux fluxcd/flux --wait --namespace fluxcd --set git.url=git@github.com:jrmcdonald/helm-charts

  printf "info: applying fluxcd HelmRelease definitions\n"
  kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/master/deploy/crds.yaml

  printf "info: installing/upgrading fluxcd helm operator\n"
  helm upgrade --install --atomic --wait helm-operator fluxcd/helm-operator --wait --namespace fluxcd --set git.ssh.secretName=flux-git-deploy --set helm.versions=v3
}

_main() {
  _setup_helm
  _install_metallb
  _install_nginx_ingress
  _install_certmanager
  _install_weave_flux
}

_main "$@"