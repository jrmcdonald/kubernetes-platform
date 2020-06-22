terraform {
  backend "s3" {
    key     = "global/s3/terraform.tfstate"
    encrypt = true
  }
}

module "provider" {
  source = "./modules/infrastructure/hcloud"

  primary_count             = var.hcloud_primary_count
  secondary_count           = var.hcloud_secondary_count
  primary_hostname_format   = var.hcloud_primary_hostname_format
  secondary_hostname_format = var.hcloud_secondary_hostname_format

  token           = var.hcloud_token
  ssh_keys        = var.hcloud_ssh_keys
  location        = var.hcloud_location
  primary_type    = var.hcloud_primary_type
  secondary_type  = var.hcloud_secondary_type
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

module "inventory" {
  source = "./modules/ansible/inventory"

  inventory_path        = var.ansible_inventory_path
  primary_hostnames     = module.provider.primary_hostnames
  primary_private_ips   = module.provider.primary_private_ips
  primary_public_ips    = module.provider.primary_public_ips
  secondary_hostnames   = module.provider.secondary_hostnames
  secondary_private_ips = module.provider.secondary_private_ips
  secondary_public_ips  = module.provider.secondary_public_ips
}

module "group_vars" {
  source = "./modules/ansible/group_vars"

  group_vars_path = var.ansible_group_vars_path
  loadbalancer_ip = module.provider.loadbalancer_ip
}