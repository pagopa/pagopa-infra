# module "tls_checker" {
#   source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//tls_checker?ref=v6.1.0"

#   https_endpoint                         = local.fdr_locals.hostname
#   alert_name                             = local.fdr_locals.hostname
#   alert_enabled                          = true
#   helm_chart_present                     = true
#   helm_chart_version                     = var.tls_cert_check_helm.chart_version
#   namespace                              = kubernetes_namespace.namespace.metadata[0].name
#   helm_chart_image_name                  = var.tls_cert_check_helm.image_name
#   helm_chart_image_tag                   = var.tls_cert_check_helm.image_tag
#   location_string                        = var.location_string
#   application_insights_connection_string = data.azurerm_application_insights.application_insights.connection_string
#   application_insights_resource_group    = data.azurerm_resource_group.monitor_rg.name
#   application_insights_id                = data.azurerm_application_insights.application_insights.id
#   application_insights_action_group_ids  = [data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.email.id]
# }

resource "helm_release" "tls_cert_check" {
  name       = "tls-cert-check"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = var.tls_cert_check_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  values = [
    "${templatefile("${path.module}/templates/tls-cert.yaml.tpl",
      {
        namespace                      = var.domain
        image_name                     = var.tls_cert_check_helm.image_name
        image_tag                      = var.tls_cert_check_helm.image_tag
        website_site_name              = "tls-cert-check-${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        time_trigger                   = "*/1 * * * *"
        function_name                  = "${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        region                         = var.location_string
        expiration_delta_in_days       = "7"
        host                           = "${var.location_short}${var.instance}.${var.domain}.internal.io.pagopa.it"
        appinsights_instrumentationkey = "ai-${var.env_short}-connection-string"
        keyvault_name                  = data.azurerm_key_vault.kv.name
        keyvault_tenantid              = data.azurerm_client_config.current.tenant_id
    })}",
  ]
}
