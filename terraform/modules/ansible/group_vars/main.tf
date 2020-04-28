resource "local_file" "inventory" {
  filename = "${var.group_vars_path}/terraform-outputs.yaml"
  content = templatefile(
    "${path.module}/templates/group_vars.tmpl",
    {
      loadbalancer_ip = var.loadbalancer_ip
    }
  )
}