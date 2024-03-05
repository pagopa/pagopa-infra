resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

module "aks_prometheus_install" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_prometheus_install?ref=v7.20.0"

  prometheus_namespace = kubernetes_namespace.monitoring.metadata[0].name
  storage_class_name   = "default-zrs" #example of ZRS storage class created by kubernetes_storage_class
}

resource "helm_release" "monitoring_reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = var.reloader_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
  set {
    name  = "reloader.deployment.image.name"
    value = var.reloader_helm.image_name
  }
  set {
    name  = "reloader.deployment.image.tag"
    value = var.reloader_helm.image_tag
  }
}
