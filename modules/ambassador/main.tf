# TODO: properly tag load balancer
resource "helm_release" "ambassador" {
  chart      = "ambassador"
  name       = "ambassador"
  repository = "https://getambassador.io"
  version    = var.ambassador_conf.version

  set {
    name  = "authService.create"
    value = false
  }
}
