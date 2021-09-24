resource "helm_release" "consul" {
  chart      = "consul"
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  version    = var.consul_conf.version

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

resource "kubernetes_manifest" "ambassador_mapping" {
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

resource "kubernetes_manifest" "ambassador_consul_resolver" {
  manifest = {
    "apiVersion" = "getambassador.io/v2"
    "kind"       = "ConsulResolver"
    "metadata" = {
      "name"      = "consul"
      "namespace" = "default"
    }
    "spec" = {
      "address" = "consul:8500"
    }
  }
}
