module "hobby-kube" {
  source = "github.com/hobby-kube/provisioning"

  domain = "${var.domain}"

  hcloud_token    = "${var.hcloud_token}"
  hcloud_ssh_keys = "${var.hcloud_ssh_keys}"

  cloudflare_email     = "${var.cloudflare_email}"
  cloudflare_api_token = "${var.cloudflare_api_token}"
}
