/* general */
variable "ansible_group_vars_path" {
  type = string
}

/* hcloud */
variable "hcloud_token" {
  type    = string
  default = ""
}

variable "hcloud_master_count" {
  default = 0
}

variable "hcloud_worker_count" {
  default = 0
}

variable "hcloud_master_hostname_format" {
  type = string
}

variable "hcloud_worker_hostname_format" {
  type = string
}

variable "hcloud_location" {
  type = string
}

variable "hcloud_master_type" {
  type = string
}

variable "hcloud_worker_type" {
  type = string
}

variable "hcloud_image" {
  type = string
}

variable "hcloud_ssh_keys" {
  type = list(string)
}

variable "hcloud_apt_packages" {
  type    = list(string)
  default = []
}

variable "hcloud_ip_range" {
  type = string
}

variable "hcloud_subnet_ip_range" {
  type = string
}

/* cloudflare dns */
variable "cloudflare_domain" {
  type = string
}

variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}