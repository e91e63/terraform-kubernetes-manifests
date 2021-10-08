resource "helm_release" "cert_manager" {
  chart      = "cert-manager"
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  version    = var.cert_manager_conf.version

  values = [
    jsonencode({
      installCRDs = true
    })
  ]
}
