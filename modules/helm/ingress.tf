resource "helm_release" "ingress" {
  name       = "nginx-ingress"
  repository = data.helm_repository.nginx-stable.url
  chart      = "nginx-ingress"
  version    = "0.4.3"
  namespace  = "ingress"

  values = [
    file("${path.module}/values/ingress.yaml")
  ]
}
