resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.kube_prometheus_stack_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  set {
    name = "alertmanagerSpec.image.registry"
    value = var.kube_prometheus_stack_helm.alertmanager.image_registry
  }
  set {
    name = "alertmanagerSpec.image.repository"
    value = var.kube_prometheus_stack_helm.alertmanager.image_name
  }
  set {
    name = "alertmanagerSpec.image.tag"
    value = var.kube_prometheus_stack_helm.alertmanager.image_tag
  }
  set {
    name = "prometheusOperator.admissionWebhooks.patch.image.registry"
    value = var.kube_prometheus_stack_helm.prometheus_operator.image_registry
  }
  set {
    name = "prometheusOperator.admissionWebhooks.patch.image.repository"
    value = var.kube_prometheus_stack_helm.prometheus_operator.image_name
  }
  set {
    name = "prometheusOperator.admissionWebhooks.patch.image.tag"
    value = var.kube_prometheus_stack_helm.prometheus_operator.image_tag
  }
}

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
