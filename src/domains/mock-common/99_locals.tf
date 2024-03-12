locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_legacy = "${var.prefix}-${var.env_short}"
  product        = "${var.prefix}-${var.env_short}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  apim_subnet_name = "${var.prefix}-${var.env_short}-apim-snet"

  vnet_resource_group_name = "${var.prefix}-${var.env_short}-vnet-rg"
  vnet_integration_name    = "${var.prefix}-${var.env_short}-vnet-integration"
  vnet_name                = "${var.prefix}-${var.env_short}-vnet"

  monitor_appinsights_name = "${local.product}-appinsights"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  cosmos_dns_zone_name                = "privatelink.mongo.cosmos.azure.com"
  cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  aks_subnet_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"

  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])
}
