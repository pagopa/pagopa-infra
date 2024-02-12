module "tls_checker" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker?ref=v6.2.1"

  https_endpoint                         = local.apiconfig_core_locals.hostname
  alert_name                             = local.apiconfig_core_locals.hostname
  alert_enabled                          = true
  helm_chart_present                     = true
  helm_chart_version                     = var.tls_cert_check_helm.chart_version
  namespace                              = kubernetes_namespace.namespace.metadata[0].name
  helm_chart_image_name                  = var.tls_cert_check_helm.image_name
  helm_chart_image_tag                   = var.tls_cert_check_helm.image_tag
  location_string                        = var.location_string
  application_insights_connection_string = "ai-${var.env_short}-connection-string"
  application_insights_resource_group    = data.azurerm_resource_group.monitor_rg.name
  application_insights_id                = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_ids  = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
  keyvault_name                          = data.azurerm_key_vault.kv.name
  keyvault_tenantid                      = data.azurerm_client_config.current.tenant_id
}


output "pa" {
  value = "${path.root}/env/${var.location_short}-${var.env}/helm/cert-mounter.yaml"
}

resource "helm_release" "cert_mounter" {
  name         = "cert-mounter-blueprint"
  repository   = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  chart        = "cert-mounter-blueprint"
  version      = "1.0.4"
  namespace    = var.domain
  timeout      = 120
  force_update = true

  values = [
    "${
      templatefile("${path.root}/helm/cert-mounter.yaml.tpl", {
        NAMESPACE        = var.domain,
        CERTIFICATE_NAME = replace(local.apiconfig_cache_locals.hostname, ".", "-"),
        ENV_SHORT        = var.env_short,
      })
    }"
  ]
}

resource "helm_release" "status_app" {
  name         = "status-app"
  repository   = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  chart        = "microservice-chart"
  version      = "2.8.0"
  namespace    = var.domain
  timeout      = 120
  force_update = true

  values = [
    "${
      templatefile("${path.root}/helm/status-app.yaml.tpl", {
        NAMESPACE   = var.domain,
        INGRESS_URL = local.apiconfig_cache_locals.hostname,
        ENV_SHORT   = var.env_short,
      })
    }"
  ]
}

resource "helm_release" "reloader" {
  name       = "reloader"
  repository = "https://stakater.github.io/stakater-charts"
  chart      = "reloader"
  version    = "v1.0.48"
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "reloader.watchGlobally"
    value = "false"
  }
}
