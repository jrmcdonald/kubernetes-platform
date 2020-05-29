terraform {
  backend "s3" {
    key     = "global/s3/terraform.tfstate"
    encrypt = true
  }
}

module "provider" {
  source = "./modules/infrastructure/hcloud"

  master_count           = var.hcloud_master_count
  worker_count           = var.hcloud_worker_count
  master_hostname_format = var.hcloud_master_hostname_format
  worker_hostname_format = var.hcloud_worker_hostname_format

  token           = var.hcloud_token
  ssh_keys        = var.hcloud_ssh_keys
  location        = var.hcloud_location
  master_type     = var.hcloud_master_type
  worker_type     = var.hcloud_worker_type
  image           = var.hcloud_image
  ip_range        = var.hcloud_ip_range
  subnet_ip_range = var.hcloud_subnet_ip_range
}

module "dns" {
  source = "./modules/infrastructure/cloudflare"

  email           = var.cloudflare_email
  api_token       = var.cloudflare_api_token
  domain          = var.cloudflare_domain
  loadbalancer_ip = module.provider.loadbalancer_ip
}

module "group_vars" {
  source = "./modules/ansible/group_vars"

  group_vars_path = var.ansible_group_vars_path
  loadbalancer_ip = module.provider.loadbalancer_ip
}