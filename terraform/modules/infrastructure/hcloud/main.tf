provider "hcloud" {
  token = var.token
}

locals {
  install_packages = [
    "while fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; do sleep 1; done",
    "apt-get update",
    "apt-get install -yq ufw ${join(" ", var.apt_packages)}",
  ]
}

resource "hcloud_server" "primary" {
  count = var.primary_count

  name        = format(var.primary_hostname_format, count.index + 1)
  location    = var.location
  image       = var.image
  server_type = var.primary_type
  ssh_keys    = var.ssh_keys

  connection {
    user    = "root"
    type    = "ssh"
    timeout = "2m"
    host    = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = local.install_packages
  }
}

resource "hcloud_server" "secondary" {
  count = var.secondary_count

  name        = format(var.secondary_hostname_format, count.index + 1)
  location    = var.location
  image       = var.image
  server_type = var.secondary_type
  ssh_keys    = var.ssh_keys

  connection {
    user    = "root"
    type    = "ssh"
    timeout = "2m"
    host    = self.ipv4_address
  }

  provisioner "remote-exec" {
    inline = local.install_packages
  }
}

resource "hcloud_volume" "primary" {
  count = var.primary_count

  name      = format(var.primary_hostname_format, count.index + 1)
  size      = 10
  server_id = element(hcloud_server.primary.*.id, count.index)
}

resource "hcloud_volume" "secondary" {
  count = var.secondary_count

  name      = format(var.secondary_hostname_format, count.index + 1)
  size      = 10
  server_id = element(hcloud_server.secondary.*.id, count.index)
}

resource "hcloud_network" "kubernetes" {
  name     = "kubernetes"
  ip_range = var.ip_range
}

resource "hcloud_network_subnet" "kubernetes" {
  network_id   = hcloud_network.kubernetes.id
  network_zone = "eu-central"
  type         = "server"
  ip_range     = var.subnet_ip_range
}

resource "hcloud_server_network" "primary" {
  count = var.primary_count

  network_id = hcloud_network.kubernetes.id
  server_id  = element(hcloud_server.primary.*.id, count.index)
}

resource "hcloud_server_network" "secondary" {
  count = var.secondary_count

  network_id = hcloud_network.kubernetes.id
  server_id  = element(hcloud_server.secondary.*.id, count.index)
}

resource "hcloud_floating_ip" "loadbalancer" {
  type          = "ipv4"
  home_location = var.location
}

resource "hcloud_floating_ip_assignment" "loadbalancer" {
  floating_ip_id = hcloud_floating_ip.loadbalancer.id
  server_id      = element(hcloud_server.secondary.*.id, 1)
}