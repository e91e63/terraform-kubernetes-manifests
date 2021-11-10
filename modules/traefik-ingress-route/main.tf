locals {
  name = "${local.service_conf.name}${local.route_conf.path != null ? "-${local.route_conf.path}" : ""}}"
  route_conf = defaults(var.route_conf, {
    service_kind = "Service"
  })
  route_path = local.route_conf.path != null ? " && Path(`/${local.route_conf.path}`)" : ""
  service_conf = defaults(var.service_conf, {
    namespace = "default"
  })
}

resource "kubernetes_manifest" "main" {
  manifest = {
    apiVersion = "traefik.containo.us/v1alpha1"
    kind       = "IngressRoute"
    metadata = {
      labels = {
        "app.kubernetes.io/names" = local.service_conf.name
      }
      name      = local.name
      namespace = "default"
    }
    spec = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match       = "Host(`${local.service_conf.name}.${var.domain_info.name}`)${local.route_path}"
          kind        = "Rule"
          middlewares = local.route_conf.middlewares
          services = [
            {
              name      = local.route_conf.service_name
              namespace = local.service_conf.namespace
              kind      = local.route_conf.service_kind
              port      = local.route_conf.service_port
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
