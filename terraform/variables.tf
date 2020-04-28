/* general */
variable "master_count" {
  default = 1
}

variable "worker_count" {
  default = 2
}

variable "domain" {
  default = "qwyck-cloud.co.uk"
}

variable "master_hostname_format" {
  default = "master-%d"
}

variable "worker_hostname_format" {
  default = "worker-%d"
}

variable "inventory_path" {
}

variable "group_vars_path" {
}

/* hcloud */
variable "hcloud_token" {
  default = ""
}

variable "hcloud_ssh_keys" {
  type = list(string)
  default = [
    "cardno:000611341223",
    "jamie@ios",
    "github-ci@qwyck.net",
  "ansible@macbook"]
}

variable "hcloud_location" {
  default = "nbg1"
}

variable "hcloud_master_type" {
  default = "cx11"
}

variable "hcloud_worker_type" {
  default = "cx11"
}

variable "hcloud_image" {
  default = "ubuntu-18.04"
}

/* cloudflare dns */
variable "cloudflare_email" {
  default = "jamie.mcdonald@qwyck.net"
}

variable "cloudflare_api_token" {
  default = ""
}