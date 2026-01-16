locals {
  product       = "${var.prefix}-${var.env_short}"
  product_italy = "${var.prefix}-${var.env_short}-${var.location_short}"
  project       = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_appinsights_italy_name  = "${local.product_italy}-core-appinsights"
  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  vnet_italy_name                = "${local.product_italy}-vnet"
  vnet_italy_resource_group_name = "${local.product_italy}-vnet-rg"

  vnet_spoke_data_name   = "${local.product_italy}-spoke-data-vnet"
  vnet_hub_spoke_rg_name = "${local.product_italy}-network-hub-spoke-rg"

  vpn_subnet_name = "GatewaySubnet"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  cosmos_dns_zone_name                = "privatelink.mongo.cosmos.azure.com"
  cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  storage_queue_dns_zone_name          = "privatelink.queue.core.windows.net"
  storage_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  aks_subnet_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-user-aks"

  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
}
