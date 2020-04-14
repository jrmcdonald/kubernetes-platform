resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

resource "helm_release" "ingress" {
  name       = "nginx-ingress"
  repository = data.helm_repository.nginx-stable.url
  chart      = "nginx-ingress"
  version    = "0.4.3"
  namespace  = kubernetes_namespace.ingress.metadata[0].name

  cleanup_on_fail = true

  values = [
    file("${path.module}/values/ingress.yaml")
  ]
}
