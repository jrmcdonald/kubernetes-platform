provider "cloudflare" {
  email     = var.email
  api_token = var.api_token
}

locals {
  zone_id = lookup(data.cloudflare_zones.domain_zones.zones[0], "id")
}

data "cloudflare_zones" "domain_zones" {
  filter {
    name   = var.domain
    status = "active"
    paused = false
  }
}

resource "cloudflare_record" "domain" {
  zone_id = local.zone_id
  name    = var.domain
  value   = var.loadbalancer_ip
  type    = "A"
  proxied = true
}

resource "cloudflare_record" "wildcard" {
  depends_on = [
  cloudflare_record.domain]

  zone_id = local.zone_id
  name    = "*"
  value   = var.domain
  type    = "CNAME"
  proxied = false
}