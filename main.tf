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
  source = "github.com/hobby-kube/provisioning"

  domain = "${var.domain}"

  hcloud_token    = "${var.hcloud_token}"
  hcloud_ssh_keys = "${var.hcloud_ssh_keys}"

  cloudflare_email     = "${var.cloudflare_email}"
  cloudflare_api_token = "${var.cloudflare_api_token}"
}

provisioner "local-exec" {
  command = <<EOT
    kubectl get nodes
    kubectl config get-contexts
    ls -l $HOME/.kube
    cp -r $HOME/.kube $GITHUB_WORKSPACE
  EOT
}