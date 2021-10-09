locals {
  do_pat_name = "digitalocean-personal-access-token"
}

resource "kubernetes_secret" "digitalocean_pat" {
  metadata {
    annotations = {}
    labels      = {}
    name        = local.do_pat_name
  }

  data = {
    (local.do_pat_name) = var.cert_issuer_conf.digitalocean_personal_access_token
  }
}

resource "kubernetes_manifest" "cert_manager_cluster_issuer_digitalocean" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "digitalocean"
    }
    spec = {
      acme = {
        email  = var.cert_issuer_conf.email
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "acme-account-key"
        }
        solvers = [
          {
            dns01 = {
              digitalocean = {
                tokenSecretRef = {
                  key  = local.do_pat_name
                  name = local.do_pat_name
                }
              }
            }
          }
        ]
      }
    }
  }
}
