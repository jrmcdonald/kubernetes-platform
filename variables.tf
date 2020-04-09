/* general */
variable "domain" {
  default = "qwyck-cloud.co.uk"
}

/* hcloud */
variable "hcloud_token" {
  default = ""
}

variable "hcloud_ssh_keys" {
  type    = list(string)
  default = ["cardno:000611341223"]
}

/* cloudflare dns */
variable "cloudflare_email" {
  default = "jamie.mcdonald@qwyck.net"
}

variable "cloudflare_api_token" {
  default = ""
}