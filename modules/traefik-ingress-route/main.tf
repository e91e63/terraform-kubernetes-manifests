resource "kubernetes_manifest" "main" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      labels = {
        "app.kubernetes.io/name" = var.service_conf.name
      }
      "name"      = var.service_conf.name
      "namespace" = var.service_conf.namespace
    }
    "spec" = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match       = "Host(`${var.service_conf.name}.${var.domain_info.name}`)"
          kind        = "Rule"
          middlewares = var.route_conf.middlewares
          services = [
            {
              name = var.route_conf.service_name
              kind = var.route_conf.service_kind
              port = var.route_conf.service_port
            }
          ]
        }
      ]
      tls = {
        secretName = var.domain_info.tls_secret_name
      }
    }
  }
}
