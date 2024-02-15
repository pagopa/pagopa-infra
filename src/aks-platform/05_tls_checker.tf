module "tls_checker" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker?ref=v7.58.0"

  for_each = { for chkr in var.tls_checker_https_endpoints_to_check : chkr.alert_name => chkr }

  https_endpoint                             = each.value.https_endpoint
  alert_name                                 = each.value.alert_name
  alert_enabled                              = each.value.alert_enabled
  helm_chart_present                         = each.value.helm_present
  helm_chart_version                         = var.tls_cert_check_helm.chart_version
  namespace                                  = kubernetes_namespace.monitoring.metadata[0].name
  helm_chart_image_name                      = var.tls_cert_check_helm.image_name
  helm_chart_image_tag                       = var.tls_cert_check_helm.image_tag
  location_string                            = var.location_string
  application_insights_connection_string     = data.azurerm_application_insights.application_insights.connection_string
  application_insights_resource_group        = data.azurerm_resource_group.monitor_rg.name
  application_insights_id                    = data.azurerm_application_insights.application_insights.id
  application_insights_action_group_slack_id = data.azurerm_monitor_action_group.slack.id
  application_insights_action_group_email_id = data.azurerm_monitor_action_group.email.id
}
