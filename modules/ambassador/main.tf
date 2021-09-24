# TODO: properly tag load balancer
resource "helm_release" "ambassador" {
  chart      = "ambassador"
  name       = "ambassador"
  repository = "https://getambassador.io"
  version    = "v6.9.1"

  set {
    name  = "authService.create"
    value = false
  }
}
