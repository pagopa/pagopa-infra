locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

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

  apim_hostname        = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  selfcare_hostname    = var.env == "prod" ? "weuprod.selfcare.internal.platform.pagopa.it" : "weu${var.env}.selfcare.internal.${var.env}.platform.pagopa.it"
  selfcare_fe_hostname = var.env == "prod" ? "selfcare.platform.pagopa.it" : "selfcare.${var.env}.platform.pagopa.it"

  # selfcare
  dns_zone_selfcare   = "selfcare"
  dns_zone_platform   = var.env == "prod" ? "platform" : "${var.env}.platform"
  external_domain     = "pagopa.it"
  selfcare_pagopa_cdn = "${var.prefix}${var.env_short}${local.dns_zone_selfcare}sa"
}
