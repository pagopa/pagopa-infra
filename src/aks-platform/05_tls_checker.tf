# resource "helm_release" "tls_cert_check_api_env_platform_pagopa_it" {
#     # count =  var.aks_private_cluster_enabled ? 1 : 0

#   name       = "tls-cert-check-api-${var.env}-platform-pagopa-it"
#   chart      = "microservice-chart"
#   repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
#   version    = var.tls_cert_check_helm.chart_version
#   namespace  = kubernetes_namespace.monitoring.metadata[0].name

#   values = [
#     "${templatefile("${path.module}/templates/tls-cert.yaml.tpl",
#       {
#         namespace                      = kubernetes_namespace.monitoring.metadata[0].name
#         image_name                     = var.tls_cert_check_helm.image_name
#         image_tag                      = var.tls_cert_check_helm.image_tag
#         website_site_name              = "api.${var.env}.platform.pagopa.it"
#         time_trigger                   = "*/1 * * * *"
#         function_name                  = "api.${var.env}.platform.pagopa.it"
#         region                         = var.location_string
#         expiration_delta_in_days       = "7"
#         host                           = "api.${var.env}.platform.pagopa.it"
#         appinsights_instrumentationkey = data.azurerm_application_insights.application_insights.connection_string
#     })}",
#   ]
# }

# resource "azurerm_monitor_metric_alert" "tls_cert_check_api_env_platform_pagopa_it" {
#     # count =  var.aks_private_cluster_enabled ? 1 : 0
#   name                = "api-${var.env}-platform-pagopa-it"
#   resource_group_name = data.azurerm_resource_group.monitor_rg.name
#   scopes              = [data.azurerm_application_insights.application_insights.id]
#   description         = "Whenever the average availabilityresults/availabilitypercentage is less than 100%"
#   severity            = 0
#   frequency           = "PT5M"
#   auto_mitigate       = false

#   criteria {
#     metric_namespace = "microsoft.insights/components"
#     metric_name      = "availabilityResults/availabilityPercentage"
#     aggregation      = "Average"
#     operator         = "LessThan"
#     threshold        = 50

#     dimension {
#       name     = "availabilityResult/name"
#       operator = "Include"
#       values   = ["api.${var.env}.platform.pagopa.it"]
#     }
#   }

#   action {
#     action_group_id = data.azurerm_monitor_action_group.slack.id
#   }

#   action {
#     action_group_id = data.azurerm_monitor_action_group.email.id
#   }
# }


module "tls_checker" {
  source = "../modules/tls_checker"

  for_each = {for chkr in var.tls_checker_https_endpoints_to_check:  chkr.alert_name => chkr}

  https_endpoint = each.value.https_endpoint
  alert_name = each.value.alert_name
  alert_enabled = each.value.alert_enabled
  helm_chart_present = each.value.helm_present
  helm_chart_version = var.tls_cert_check_helm.chart_version
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  helm_chart_image_name = var.tls_cert_check_helm.image_name
  helm_chart_image_tag = var.tls_cert_check_helm.image_tag
  location_string = var.location_string
  application_insights_connection_string = data.azurerm_application_insights.application_insights.connection_string
  application_insights_resource_group = data.azurerm_resource_group.monitor_rg.name
  application_insights_id = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_slack_id = data.azurerm_monitor_action_group.slack.id
  application_insights_action_group_email_id = data.azurerm_monitor_action_group.email.id
}
