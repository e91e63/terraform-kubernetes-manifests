resource "helm_release" "consul" {
  chart      = "consul"
  name       = "consul"
  repository = "https://helm.releases.hashicorp.com"
  version    = var.consul_conf.version

  values = [
    jsonencode({
      connectInject = {
        default = false
        enabled = true
      }
      controller = {
        enabled = true
      }
      global = {
        name       = "consul"
        datacenter = "dc1"
        metrics = {
          enabled = true
        }
        # tls = {
        #   # acls = {
        #   #   manageSystemACLs = true
        #   # }
        #   enabled           = true
        #   enableAutoEncrypt = true
        #   # gossipEncryption = {
        #   #   secretName = "consul-gossip-encryption-key"
        #   #   secretKey  = "key"
        #   # }
        #   verify = true
        #   serverAdditionalDNSSANs = [
        #     "consul-server.default.svc.cluster.local"
        #   ]
        # }
      }
      grafana = {
        enabled = true
      }
      prometheus = {
        enabled = true
      }
      syncCatalog = {
        default  = false
        enabled  = true
        toConsul = true
        toK8S    = false
      },
      ui = {
        enabled = true
      }
    })
  ]
}

resource "kubernetes_manifest" "traefik_ingress_route" {
  manifest = {
    "apiVersion" = "traefik.containo.us/v1alpha1"
    "kind"       = "IngressRoute"
    "metadata" = {
      "name"      = "consul"
      "namespace" = "default"
    }
    "spec" = {
      entryPoints = [
        "websecure",
      ]
      routes = [
        {
          match = "Host(`consul.e91e63.tech`)"
          kind  = "Rule"
          middlewares = [
            {
              name = "admin-users"
            }
          ]
          services = [
            {
              name = "consul-ui"
              port = 80
            }
          ]
        }
      ]
      tls = {
        secretName = "e91e63.tech-cert"
      }
    }
  }
}
