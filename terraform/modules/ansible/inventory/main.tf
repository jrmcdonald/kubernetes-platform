resource "local_file" "inventory" {
  filename = "${var.inventory_path}/production"
  content = templatefile(
    "${path.module}/templates/inventory.tmpl",
    {
      primary_hostnames     = var.primary_hostnames,
      primary_public_ips    = var.primary_public_ips,
      primary_private_ips   = var.primary_private_ips,
      secondary_hostnames   = var.secondary_hostnames,
      secondary_public_ips  = var.secondary_public_ips,
      secondary_private_ips = var.secondary_private_ips,
    }
  )
}