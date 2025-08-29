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
  pagopa_apim_snet = "${local.product}-apim-snet"

  pagopa_vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  pagopa_vnet_rg          = "pagopa-${var.env_short}-vnet-rg"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  aca_hostname  = "${var.location_short}${var.env}.aca.internal.${var.apim_dns_zone_prefix}.${var.external_domain}"

  apim_debt_positions_for_aca_service_api = {
    display_name          = "GPD for ACA pagoPA - Debt Positions service API for ACA"
    description           = "API to support Debt Positions service for ACA"
    path                  = "aca/debt-positions-service"
    subscription_required = true
    service_url           = var.env == "prod" ? "https://weu${var.env}.gps.internal.platform.pagopa.it/pagopa-gpd-core" : "https://weu${var.env}.gps.internal.${var.env}.platform.pagopa.it/pagopa-gpd-core"
  }
  apim_aca_upload_api = {
    display_name          = "ACA Upload pagoPA - Massive Upload"
    description           = "API to support ACA's Debt Positions massive upload for organizations"
    path                  = "upload/aca/debt-positions-service"
    subscription_required = true
    service_url           = var.env == "prod" ? "https://weu${var.env}.gps.internal.platform.pagopa.it/pagopa-gpd-upload" : "https://weu${var.env}.gps.internal.${var.env}.platform.pagopa.it/pagopa-gpd-upload"
  }
}
