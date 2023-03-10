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

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

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

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"

  apiconfig_core_locals = {
    hostname = var.env == "prod" ? "weuprod.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"

    product_id            = "apiconfig-core"
    display_name          = "API Config Core"
    description           = "Management APIs to configure pagoPA"
    subscription_required = true

    path        = "apiconfig-core"
    service_url = null

    pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id
    apiconfig_be_client_id = data.azuread_application.apiconfig-be.application_id
    apiconfig_fe_client_id = data.azuread_application.apiconfig-fe.application_id
  }

  apiconfig_cache_locals = {
    hostname = var.env == "prod" ? "weuprod.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"

    product_id            = "apiconfig-cache"
    display_name          = "API Config Cache"
    description           = "Management APIs to configure pagoPA cache"
    subscription_required = true
    subscription_limit    = 1000

    path        = "api-config-cache"
    service_url = null

    pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id
  }
}

