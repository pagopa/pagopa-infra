locals {
  project          = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product          = "${var.prefix}-${var.env_short}"
  product_location = "${var.prefix}-${var.env_short}-${var.location_short}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_action_group_slack_name          = "SlackPagoPANODO"
  monitor_action_group_email_name          = "PagoPA"
  monitor_action_group_opsgenie_name       = "Opsgenie"
  monitor_action_group_infra_opsgenie_name = "InfraOpsgenie"
  monitor_appinsights_name                 = "${local.product}-appinsights"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"
  vnet_integration_name    = "${local.product}-vnet-integration"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
  aks_subnet_name         = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"

  ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  apim_snet     = "${local.product}-apim-snet"
  nodo_hostname = var.env == "prod" ? "${var.location_short}${var.env}.${var.domain}.internal.platform.pagopa.it" : "${var.location_short}${var.env}.${var.domain}.internal.${var.env}.platform.pagopa.it"

  nodo_datamigration_hostname = "${local.nodo_hostname}/datamigration"

  apim_for_node = {
    product_id            = "apim_for_node"
    display_name          = "APIM for Nodo"
    description           = "Management of APIs called by Nodo"
    subscription_required = true
    approval_required     = true
    subscription_limit    = 1000
  }

  activate_identifier = {
    dev  = "63bff3b4c257811280ef762c"
    uat  = "63d1611e451c1c1948ef3e84"
    prod = "63d93fefc733b51860039d50"
  }

  activate_v2_identifier = {
    dev  = "63bff3b4c257811280ef7631"
    uat  = "63d1611e451c1c1948ef3e89"
    prod = "63d93fefc733b51860039d55"
  }


  # config vars to mng sendPaymentResultV2
  # https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/654541075/RFC+Gestione+clientId+per+integrazione+Software+Client#Backend
  # endpoint1           = "https://mil-${var.env_short}-apim.azure-api.net/mil-payment-notice/payments/{transactionId}"
  # endpoint2           = "https://api.${var.env}.platform.pagopa.it/ecommerce/transaction-user-receipts-service/v1/transactions/{transactionId}/user-receipts"
  endpoint1           = "mil-${var.env_short}-apim.azure-api.net"
  endpoint2           = "api.${var.env}.platform.pagopa.it"
  authorizationServer = "https://mil-${var.env_short}-apim.azure-api.net/mil-auth/token"
  # scope               = "scope"
  # clientId            by KV
  # clientSecret        by KV
  # subscriptionKey     by KV # ecommerce pagoPA - transaction user receipts service API
}
