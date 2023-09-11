locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"
  monitor_appinsights_name           = "${local.product}-appinsights"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  pagopa_apim_snet        = "${local.product}-apim-snet"
  pagopa_vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  pagopa_vnet_rg          = "pagopa-${var.env_short}-vnet-rg"

  apim_hostname      = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  shared_hostname    = var.env == "prod" ? "weuprod.shared.internal.platform.pagopa.it" : "weu${var.env}.shared.internal.${var.env}.platform.pagopa.it"
  hostnameAzFunction = var.env == "prod" ? "pagopa-weu-shared-txnm-fn.azurewebsites.net" : "pagopa-${var.env_short}-weu-shared-txnm-fn.azurewebsites.net"

  cache_generator_hostname   = "${var.prefix}-${var.env_short}-${var.location_short}-shared-authorizer-fn.azurewebsites.net/api"
  cache_generator_hostname_2 = "${var.prefix}-${var.env_short}-${var.location_short}-shared-authorizer-fn.azurewebsites.net"

  authorizer_config_hostname = "${local.shared_hostname}/authorizer-config"

  # DOMAINS
  system_domain_namespace = kubernetes_namespace.system_domain_namespace.metadata[0].name
  domain_namespace        = kubernetes_namespace.namespace.metadata[0].name

  authorizer_healthcheck_criteria = {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 99
  }
  authorizer_healthcheck_action = var.env_short == "p" ? [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id,
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.opsgenie[0].id,
      webhook_properties = null
    }
    ] : [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id,
      webhook_properties = null
    }
  ]
}
