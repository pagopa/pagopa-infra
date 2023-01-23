resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "prometheus"
#   version    = var.prometheus_helm.chart_version
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name

#   set {
#     name  = "server.global.scrape_interval"
#     value = "30s"
#   }
#   set {
#     name  = "alertmanager.image.repository"
#     value = var.prometheus_helm.alertmanager.image_name
#   }
#   set {
#     name  = "alertmanager.image.tag"
#     value = var.prometheus_helm.alertmanager.image_tag
#   }
#   set {
#     name  = "alertmanager.configmapReload.prometheus.image.repository"
#     value = var.prometheus_helm.configmap_reload_prometheus.image_name
#   }
#   set {
#     name  = "alertmanager.configmapReload.prometheus.image.tag"
#     value = var.prometheus_helm.configmap_reload_prometheus.image_tag
#   }
#   set {
#     name  = "alertmanager.configmapReload.alertmanager.image.repository"
#     value = var.prometheus_helm.configmap_reload_alertmanager.image_name
#   }
#   set {
#     name  = "alertmanager.configmapReload.alertmanager.image.tag"
#     value = var.prometheus_helm.configmap_reload_alertmanager.image_tag
#   }
#   set {
#     name  = "alertmanager.nodeExporter.image.repository"
#     value = var.prometheus_helm.node_exporter.image_name
#   }
#   set {
#     name  = "alertmanager.nodeExporter.image.tag"
#     value = var.prometheus_helm.node_exporter.image_tag
#   }
#   set {
#     name  = "alertmanager.nodeExporter.image.repository"
#     value = var.prometheus_helm.node_exporter.image_name
#   }
#   set {
#     name  = "alertmanager.nodeExporter.image.tag"
#     value = var.prometheus_helm.node_exporter.image_tag
#   }
#   set {
#     name  = "alertmanager.server.image.repository"
#     value = var.prometheus_helm.server.image_name
#   }
#   set {
#     name  = "alertmanager.server.image.tag"
#     value = var.prometheus_helm.server.image_tag
#   }
#   set {
#     name  = "alertmanager.pushgateway.image.repository"
#     value = var.prometheus_helm.pushgateway.image_name
#   }
#   set {
#     name  = "alertmanager.pushgateway.image.tag"
#     value = var.prometheus_helm.pushgateway.image_tag
#   }
# }

# resource "helm_release" "grafana" {
#   name       = "grafana"
#   repository = "https://grafana.github.io/helm-charts"
#   chart      = "grafana"
#   version    = var.grafana_helm_version
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name

#   set {
#     name  = "adminUser"
#     value = data.azurerm_key_vault_secret.grafana_admin_username.value
#   }

#   set {
#     name  = "adminPassword"
#     value = data.azurerm_key_vault_secret.grafana_admin_password.value
#   }
# }

# resource "kubernetes_config_map" "akka_actors" {
#   metadata {
#     name      = "grafana-dashboard-akka-actors"
#     namespace = "monitoring"
#     labels = {
#        grafana_dashboard = 1
#     }
#   }

#   data = {
#     "akka-actors.json" = "${file("${var.kube_prometheus_stack_helm.dashboard_akka_actors}")}"
#   }
# }

resource "kubernetes_secret_v1" "prometheus_basic_auth" {
  metadata {
    name = "prometheus-basic-auth"
    namespace = "monitoring"
  }

  data = {
    "auth" = "${file("${var.prometheus_basic_auth_file}")}"
  }

}

resource "helm_release" "kube_prometheus_stack" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.kube_prometheus_stack_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  values = [
    "${file("${var.kube_prometheus_stack_helm.values_file}")}"
  ]

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
