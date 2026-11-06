locals {
  project          = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product          = "${var.prefix}-${var.env_short}"
  product_location = "${var.prefix}-${var.env_short}-${var.location_short}"

  # monitor_action_group_slack_name                 = "SlackPagoPANODO"
  # monitor_action_group_slack_pagamenti_alert_name = "PagamentiAlert"
  # monitor_action_group_email_name                 = "PagoPA"
  # monitor_action_group_opsgenie_name              = "Opsgenie"
  # monitor_action_group_infra_opsgenie_name        = "InfraOpsgenie"
  # monitor_action_group_cloudo_name                = "pagopa-${var.env_short}-cloudo-trigger"
  # cloudo_action_group_rg_name                     = "${local.product}-itn-cloudo-rg"
  # monitor_appinsights_name                        = "${local.product}-appinsights"
  #
  # vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"
  # vnet_integration_name    = "${local.product}-vnet-integration"
  #
  # acr_name                = replace("${local.product}commonacr", "-", "")
  # acr_resource_group_name = "${local.product}-container-registry-rg"
  #
  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  # aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
  # aks_subnet_name         = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"
  #
  # ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  # internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  #
  # pagopa_apim_name = "${local.product}-apim"
  # pagopa_apim_rg   = "${local.product}-api-rg"
  #
  # apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  # apim_snet     = "${local.product}-apim-snet"
  # nodo_hostname = var.env == "prod" ? "${var.location_short}${var.env}.${var.domain}.internal.platform.pagopa.it" : "${var.location_short}${var.env}.${var.domain}.internal.${var.env}.platform.pagopa.it"

  dns_zone_nodo_observability = "observability"
  dns_zone_platform   = var.env == "prod" ? "platform" : "${var.env}.platform"
  external_domain     = "pagopa.it"
}
