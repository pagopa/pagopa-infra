locals {
  project         = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_replica = "${var.prefix}-${var.env_short}-${var.location_replica_short}-${var.domain}"
  product         = "${var.prefix}-${var.env_short}"

  function_app_name = "${local.product}-fn-reportingfdr-fdr"

  subscription_name = "${var.env}-${var.prefix}"

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

  vnet_name                = "${local.product}-vnet"
  vnet_replica_name        = "${local.product}-${var.location_replica_short}-core-replica-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  vnet_italy_name        = "${local.product}-${var.location_replica_short}-vnet"
  vnet_italy_rg_name        = "${local.product}-${var.location_replica_short}-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  aks_subnet_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"

  cosmos_dns_zone_name                = "privatelink.mongo.cosmos.azure.com"
  cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  monitor_appinsights_name = "${local.product}-appinsights"

  evt_hub_location                   = "weu-core"
  monitor_action_group_opsgenie_name = "Opsgenie"
}
