terraform {
  backend "s3" {
    key     = "global/s3/terraform.tfstate"
    encrypt = true
  }
}

module "provider" {
  source = "./modules/infrastructure/hcloud"

  master_count           = var.master_count
  worker_count           = var.worker_count
  master_hostname_format = var.master_hostname_format
  worker_hostname_format = var.worker_hostname_format

  token       = var.hcloud_token
  ssh_keys    = var.hcloud_ssh_keys
  location    = var.hcloud_location
  master_type = var.hcloud_master_type
  worker_type = var.hcloud_worker_type
  image       = var.hcloud_image
}

module "dns" {
  source = "./modules/infrastructure/cloudflare"

  email           = var.cloudflare_email
  api_token       = var.cloudflare_api_token
  domain          = var.domain
  loadbalancer_ip = module.provider.loadbalancer_ip
}

module "inventory" {
  source = "./modules/ansible/inventory"

  inventory_path     = var.inventory_path
  loadbalancer_ip    = module.provider.loadbalancer_ip
  master_hostnames   = module.provider.master_hostnames
  master_private_ips = module.provider.master_private_ips
  master_public_ips  = module.provider.master_public_ips
  worker_hostnames   = module.provider.worker_hostnames
  worker_private_ips = module.provider.worker_private_ips
  worker_public_ips  = module.provider.worker_public_ips
}