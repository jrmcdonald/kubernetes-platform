variable "kubeconfig_path" {
  type = string
}

provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

data "helm_repository" "nginx-stable" {
  name = "nginx-stable"
  url  = "https://helm.nginx.com/stable"
}
