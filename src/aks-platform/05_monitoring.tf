resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

resource "kubernetes_secret_v1" "prometheus_basic_auth" {
  metadata {
    name      = "prometheus-basic-auth"
    namespace = "elastic-system"
  }

  data = {
    "auth" = "${file("${var.prometheus_basic_auth_file}")}"
  }
}

module "monitoring_pod_identity" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_pod_identity?ref=v8.53.0"

  cluster_name        = module.aks.name
  resource_group_name = azurerm_resource_group.aks_rg.name
  location            = var.location
  tenant_id           = data.azurerm_subscription.current.tenant_id

  identity_name = "monitoring-pod-identity"
  namespace     = kubernetes_namespace.monitoring.metadata[0].name
  key_vault_id  = data.azurerm_key_vault.kv.id

  secret_permissions = ["Get"]
}

resource "helm_release" "kube_prometheus_stack" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = var.kube_prometheus_stack_helm.chart_version
  namespace  = "elastic-system" #kubernetes_namespace.monitoring.metadata[0].name

  values = [
    "${file("${var.kube_prometheus_stack_helm.values_file}")}"
  ]

  lifecycle {
    ignore_changes = [
      metadata
    ]
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

module "opencosts" {
  enable_opencost      = var.env_short == "d" ? true : false
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_opencosts?ref=v8.71.0"
  aks_name             = module.aks.name
  aks_rg_name          = module.aks.aks_resource_group_name
  env                  = var.env
  kubernetes_namespace = "elastic-system"
  prometheus_config = {
    namespace    = "elastic-system"
    service_name = "prometheus-kube-prometheus-prometheus"
    service_port = "9090"
    external_url = "https://api.${var.env}.platform.pagopa.it/prometheus"
  }
}

resource "kubernetes_manifest" "service_monitor" {
  count = var.env_short == "d" ? 1 : 0
  manifest = {
    "apiVersion" : "azmonitoring.coreos.com/v1"
    "kind" : "ServiceMonitor"
    "metadata" : {
      "name" : "prometheus-opencosts"
      "namespace" : "elastic-system"
      "labels" : {
        "app.kubernetes.io/instance" : "prometheus"
        "app.kubernetes.io/part-of" : "kube-prometheus-stack"
        "app" : "kube-prometheus-stack-operator"
      }
    }
    "spec" : {
      "selector" : {
        "matchLabels" : {
          "app.kubernetes.io/instance" : "prometheus-opencost-exporter"
          "app.kubernetes.io/name" : "opencost"
        }
      }
      "endpoints" : [
        {
          "port" : "http"
          "interval" : "30s"
          "path" : "/metrics"
        }
      ]
      jobLabel : "opencost"
    }
  }
}

# Refer: Resource created on next-core 02_monitor.tf
data "azurerm_monitor_workspace" "workspace" {
  name                = "pagopa-${var.env_short}-monitor-workspace"
  resource_group_name = "pagopa-${var.env_short}-monitor-rg"
}

module "prometheus_managed_addon" {
  source                 = "git::https://github.com/pagopa/terraform-azurerm-v3.git//kubernetes_prometheus_managed?ref=v8.83.1"
  cluster_name           = module.aks.name
  resource_group_name    = module.aks.aks_resource_group_name
  location               = var.location
  location_short         = var.location_short
  monitor_workspace_name = data.azurerm_monitor_workspace.workspace.name
  monitor_workspace_rg   = data.azurerm_monitor_workspace.workspace.resource_group_name
  grafana_name           = "pagopa-${var.env_short}-${var.location_short}-grafana"
  grafana_resource_group = "pagopa-${var.env_short}-${var.location_short}-grafana-rg"

  # takes a list and replaces any elements that are lists with a
  # flattened sequence of the list contents.
  # In this case, we enable OpsGenie only on prod env
  action_groups_id = flatten([
    [
      data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.email.id
    ],
    (var.env == "prod" ? [
      data.azurerm_monitor_action_group.opsgenie.0.id
    ] : [])
  ])

  tags = module.tag_config.tags
}
