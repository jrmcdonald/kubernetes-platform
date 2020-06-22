output "loadbalancer_ip" {
  value = hcloud_floating_ip.loadbalancer.ip_address
}

output "primary_hostnames" {
  value = hcloud_server.primary.*.name
}

output "primary_public_ips" {
  value = zipmap(hcloud_server.primary.*.name, hcloud_server.primary.*.ipv4_address)
}

output "primary_private_ips" {
  value = zipmap(hcloud_server.primary.*.name, hcloud_server_network.primary.*.ip)
}

output "secondary_hostnames" {
  value = hcloud_server.secondary.*.name
}

output "secondary_public_ips" {
  value = zipmap(hcloud_server.secondary.*.name, hcloud_server.secondary.*.ipv4_address)
}

output "secondary_private_ips" {
  value = zipmap(hcloud_server.secondary.*.name, hcloud_server_network.secondary.*.ip)
}
