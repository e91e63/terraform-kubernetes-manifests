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

resource "kubernetes_manifest" "ambassador_mapping_consul" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "Mapping"
    "metadata" = {
      "name"      = "consul"
      "namespace" = "default"
    }
    "spec" = {
      "prefix"  = "/consul/"
      "rewrite" = "/consul/"
      "service" = "consul-consul-server:8500"
    }
  }
}
