resource "helm_release" "tls_cert_check_api_env_platform_pagopa_it" {
    # count =  var.aks_private_cluster_enabled ? 1 : 0

  name       = "tls-cert-check-api-${var.env}-platform-pagopa-it"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = var.tls_cert_check_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name

  values = [
    "${templatefile("${path.module}/templates/tls-cert.yaml.tpl",
      {
        namespace                      = kubernetes_namespace.monitoring.metadata[0].name
        image_name                     = var.tls_cert_check_helm.image_name
        image_tag                      = var.tls_cert_check_helm.image_tag
        website_site_name              = "api.${var.env}.platform.pagopa.it"
        time_trigger                   = "*/1 * * * *"
        function_name                  = "api.${var.env}.platform.pagopa.it"
        region                         = var.location_string
        expiration_delta_in_days       = "7"
        host                           = "api.${var.env}.platform.pagopa.it"
        appinsights_instrumentationkey = data.azurerm_application_insights.application_insights.connection_string
    })}",
  ]
}

resource "azurerm_monitor_metric_alert" "tls_cert_check_api_env_platform_pagopa_it" {
    # count =  var.aks_private_cluster_enabled ? 1 : 0
  name                = "api-${var.env}-platform-pagopa-it"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  scopes              = [data.azurerm_application_insights.application_insights.id]
  description         = "Whenever the average availabilityresults/availabilitypercentage is less than 100%"
  severity            = 0
  frequency           = "PT5M"
  auto_mitigate       = false

  criteria {
    metric_namespace = "microsoft.insights/components"
    metric_name      = "availabilityResults/availabilityPercentage"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 50

    dimension {
      name     = "availabilityResult/name"
      operator = "Include"
      values   = ["api.${var.env}.platform.pagopa.it"]
    }
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.email.id
  }
}
