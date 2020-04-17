output "loadbalancer_ip" {
  value = hcloud_floating_ip.loadbalancer.ip_address
}

output "master_hostnames" {
  value = hcloud_server.master.*.name
}

output "master_public_ips" {
  value = zipmap(hcloud_server.master.*.name, hcloud_server.master.*.ipv4_address)
}

output "master_private_ips" {
  value = zipmap(hcloud_server.master.*.name, hcloud_server_network.master.*.ip)
}

output "worker_hostnames" {
  value = hcloud_server.worker.*.name
}

output "worker_public_ips" {
  value = zipmap(hcloud_server.worker.*.name, hcloud_server.worker.*.ipv4_address)
}

output "worker_private_ips" {
  value = zipmap(hcloud_server.worker.*.name, hcloud_server_network.worker.*.ip)
}
