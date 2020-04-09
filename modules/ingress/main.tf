data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "ingress" {
  name       = "nginx-ingress"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "nginx-ingress"
  version    = "0.30.0"
  namespace  = "ingress"

  values = [
    "${file("${path.module}/values.yaml")}"
  ]
}
