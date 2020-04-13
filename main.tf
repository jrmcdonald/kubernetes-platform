terraform {
  backend "s3" {
    bucket = "qwyck-platform-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-1"

    dynamodb_table = "qwyck-platform-terraform-lock"
    encrypt        = true
  }
}

module "hobby-kube" {
  source = "github.com/jrmcdonald/provisioning"

  domain = var.domain

  hcloud_token    = var.hcloud_token
  hcloud_ssh_keys = var.hcloud_ssh_keys

  cloudflare_email     = var.cloudflare_email
  cloudflare_api_token = var.cloudflare_api_token
}

module "kubeconfig" {
  source = "./modules/kubeconfig"

  kubeconfig_depends_on = [module.hobby-kube.kubernetes_overlay_cidr]
  cluster_name          = var.domain
}