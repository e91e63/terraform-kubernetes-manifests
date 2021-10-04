resource "kubernetes_pod" "alpine" {
  metadata {
    name      = var.alpine_conf.name
    namespace = "default"
  }

  spec {
    container {
      command = ["sleep", "infinity"]
      image   = var.alpine_conf.image
      name    = var.alpine_conf.name
    }
  }
}
