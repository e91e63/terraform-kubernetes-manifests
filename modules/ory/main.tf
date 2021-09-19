resource "helm_release" "ory_kratos" {
  chart   = "ory/kratos"
  name    = "ory-kratos"
  version = "0.19.3"

  values = [

  ]
}

resource "helm_release" "ory_oathkeeper" {
  chart   = "ory/oathkeeper"
  name    = "ory-oathkeeper"
  version = "0.19.3"
}

resource "kubernetes_manifest" "ory_kratos" {
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
