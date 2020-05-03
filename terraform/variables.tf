/* general */
variable "master_count" {}

variable "worker_count" {}

variable "domain" {}

variable "master_hostname_format" {}

variable "worker_hostname_format" {}

variable "inventory_path" {}

variable "group_vars_path" {}

/* hcloud */
variable "hcloud_token" {}

variable "hcloud_ssh_keys" {}

variable "hcloud_location" {}

variable "hcloud_master_type" {}

variable "hcloud_worker_type" {}

variable "hcloud_image" {}

/* cloudflare dns */
variable "cloudflare_email" {}

variable "cloudflare_api_token" {}