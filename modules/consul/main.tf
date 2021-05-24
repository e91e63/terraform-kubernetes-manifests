resource "helm_release" "consul" {
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  version    = "v0.31.1"

  #   values = [
  #     "${file("values.yaml")}"
  #   ]

  #   set {
  #     name  = "cluster.enabled"
  #     value = "true"
  #   }

  #   set {
  #     name  = "metrics.enabled"
  #     value = "true"
  #   }

  #   set {
  #     name  = "service.annotations.prometheus\\.io/port"
  #     value = "9127"
  #     type  = "string"
  #   }
}
