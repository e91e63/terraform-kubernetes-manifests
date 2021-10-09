resource "kubernetes_manifest" "main" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      labels = {
        "app.kubernetes.io/name" = var.service_conf.name
      }
      "name"      = var.service_conf.name
      "namespace" = "default"
    }
    "spec" = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match       = "Host(`${var.service_conf.name}.${var.domain_info.name}`)"
          kind        = "Rule"
          middlewares = var.service_conf.middlewares
          services = [
            {
              name = var.service_conf.name
              port = 80
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
