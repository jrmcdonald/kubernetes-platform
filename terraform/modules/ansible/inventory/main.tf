resource "local_file" "inventory" {
  filename = "${var.inventory_path}/production"
  content = templatefile(
    "${path.module}/templates/inventory.tmpl",
    {
      loadbalancer_ip    = var.loadbalancer_ip
      master_hostnames   = var.master_hostnames,
      master_public_ips  = var.master_public_ips,
      master_private_ips = var.master_private_ips,
      worker_hostnames   = var.worker_hostnames,
      worker_public_ips  = var.worker_public_ips,
      worker_private_ips = var.worker_private_ips,
    }
  )
}