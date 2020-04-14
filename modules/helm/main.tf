variable "kubeconfig_path" {
  type = string
}

provider "helm" {
  debug = true
  
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
