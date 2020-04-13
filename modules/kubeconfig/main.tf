variable "kubeconfig_depends_on" {
  type    = any
  default = null
}

variable "cluster_name" {
  type = "string"
}

variable "api_secure_port" {
  default = "6443"
}

resource "null_resource" "kubectl" {
  depends_on = [var.kubeconfig_depends_on]

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "${path.module}/kubeconfig.sh ${var.cluster_name} ${var.api_secure_port}"
  }
}

data "local_file" "kubeconfig" {
  depends_on = ["null_resource.kubectl"]
  filename   = pathexpand("~/.kube/config")
}

resource "local_file" "kubeconfig" {
  sensitive_content = data.local_file.kubeconfig.content
  filename          = "${path.root}/.kubeconfig"
}