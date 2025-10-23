locals {
  project       = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product       = "${var.prefix}-${var.env_short}"
  product_italy = "${var.prefix}-${var.env_short}-${var.location_short}"


  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_appinsights_italy_name  = "${local.product_italy}-core-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  monitor_appinsights_name        = "${local.product}-appinsights"

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

  apim_hostname             = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  payment_wallet_hostname   = var.env_short != "p" ? "${var.location_short}${var.env}.pay-wallet.internal.${var.env}.platform.pagopa.it" : "${var.location_short}${var.env}.pay-wallet.internal.platform.pagopa.it"
  ecommerce_hostname        = var.env_short == "p" ? "weu${var.env}.ecommerce.internal.platform.pagopa.it" : "weu${var.env}.ecommerce.internal.${var.env}.platform.pagopa.it"
  wallet_service_hostname   = var.env_short != "p" ? "weu${var.env}.wallet.internal.${var.env}.platform.pagopa.it" : "${var.location_short}${var.env}.pay-wallet.internal.platform.pagopa.it"
  checkout_ingress_hostname = var.env_short != "p" ? "weu${var.env}.checkout.internal.${var.env}.platform.pagopa.it" : "${var.location_short}${var.env}.checkout.internal.platform.pagopa.it"
}
