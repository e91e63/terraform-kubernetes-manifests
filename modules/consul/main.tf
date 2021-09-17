resource "helm_release" "consul" {
  chart      = "consul"
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  version    = "v0.33.0"

  values = [
    jsonencode({
      connectInject = {
        enabled = true
      }
      syncCatalog = {
        enabled = true
      },
      ui = {
        enabled = true
      }
    })
  ]
}
