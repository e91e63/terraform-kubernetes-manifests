resource "kubernetes_pod" "alpine" {
  lifecycle {
    ignore_changes = [
      spec.0.container.0.volume_mount
    ]
  }

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
