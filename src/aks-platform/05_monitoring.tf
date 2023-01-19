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
    value = var.kube_prometheus_stack_helm.alertmanager.image_repository
  }
  set {
    name = "alertmanagerSpec.image.tag"
    value = var.kube_prometheus_stack_helm.alertmanager.image_tag
  }
  set {
    name = "alertmanagerSpec.image.sha"
    value = var.kube_prometheus_stack_helm.alertmanager.image_sha
  }


  set {
    name = "prometheusOperator.admissionWebhooks.patch.image.registry"
    value = var.kube_prometheus_stack_helm.kube_webhook_certgen.image_registry
  }
  set {
    name = "prometheusOperator.admissionWebhooks.patch.image.repository"
    value = var.kube_prometheus_stack_helm.kube_webhook_certgen.image_repository
  }
  set {
    name = "prometheusOperator.admissionWebhooks.patch.image.tag"
    value = var.kube_prometheus_stack_helm.kube_webhook_certgen.image_tag
  }
  set {
    name = "prometheusOperator.admissionWebhooks.patch.image.sha"
    value = var.kube_prometheus_stack_helm.kube_webhook_certgen.image_sha
  }

  set {
    name = "prometheusOperator.image.registry"
    value = var.kube_prometheus_stack_helm.prometheus_operator.image_registry
  }
  set {
    name = "prometheusOperator.image.repository"
    value = var.kube_prometheus_stack_helm.prometheus_operator.image_repository
  }
  set {
    name = "prometheusOperator.image.tag"
    value = var.kube_prometheus_stack_helm.prometheus_operator.image_tag
  }
  set {
    name = "prometheusOperator.image.sha"
    value = var.kube_prometheus_stack_helm.prometheus_operator.image_sha
  }

  set {
    name = "prometheusOperator.prometheusConfigReloader.image.registry"
    value = var.kube_prometheus_stack_helm.prometheus_config_reloader.image_registry
  }
  set {
    name = "prometheusOperator.prometheusConfigReloader.image.repository"
    value = var.kube_prometheus_stack_helm.prometheus_config_reloader.image_repository
  }
  set {
    name = "prometheusOperator.prometheusConfigReloader.image.tag"
    value = var.kube_prometheus_stack_helm.prometheus_config_reloader.image_tag
  }
  set {
    name = "prometheusOperator.prometheusConfigReloader.image.sha"
    value = var.kube_prometheus_stack_helm.prometheus_config_reloader.image_sha
  }

  set {
    name = "prometheusOperator.thanosImage.image.registry"
    value = var.kube_prometheus_stack_helm.thanos.image_registry
  }
  set {
    name = "prometheusOperator.thanosImage.image.repository"
    value = var.kube_prometheus_stack_helm.thanos.image_repository
  }
  set {
    name = "prometheusOperator.thanosImage.image.tag"
    value = var.kube_prometheus_stack_helm.thanos.image_tag
  }
  set {
    name = "prometheusOperator.thanosImage.image.sha"
    value = var.kube_prometheus_stack_helm.thanos.image_sha
  }

  set {
    name = "prometheus.prometheusSpec.image.registry"
    value = var.kube_prometheus_stack_helm.prometheus.image_registry
  }
  set {
    name = "prometheus.prometheusSpec.image.repository"
    value = var.kube_prometheus_stack_helm.prometheus.image_repository
  }
  set {
    name = "prometheus.prometheusSpec.image.tag"
    value = var.kube_prometheus_stack_helm.prometheus.image_tag
  }
  set {
    name = "prometheus.prometheusSpec.image.sha"
    value = var.kube_prometheus_stack_helm.thanos.image_sha
  }

  set {
    name = "thanosRuler.thanosRulerSpec.image.registry"
    value = var.kube_prometheus_stack_helm.thanos.image_registry
  }
  set {
    name = "thanosRuler.thanosRulerSpec.image.repository"
    value = var.kube_prometheus_stack_helm.thanos.image_repository
  }
  set {
    name = "thanosRuler.thanosRulerSpec.image.tag"
    value = var.kube_prometheus_stack_helm.thanos.image_tag
  }
  set {
    name = "thanosRuler.thanosRulerSpec.image.sha"
    value = var.kube_prometheus_stack_helm.thanos.image_sha
  }

  set {
    name = "prometheus.prometheusSpec.ingress.enabled"
    value = var.kube_prometheus_stack_helm.prometheus_ingress.enabled
  }
  set {
    name = "prometheus.prometheusSpec.ingress.hosts[0]"
    value = var.kube_prometheus_stack_helm.prometheus_ingress.host
  }
  set {
    name = "prometheus.prometheusSpec.ingress.tls[0].secretName"
    value = var.kube_prometheus_stack_helm.prometheus_ingress.tls_secret_name
  }
  set {
    name = "prometheus.prometheusSpec.ingress.tls[0].hosts[0]"
    value = var.kube_prometheus_stack_helm.prometheus_ingress.tls_secret_host
  }

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
