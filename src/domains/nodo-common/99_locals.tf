locals {
  project         = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_replica = "${var.prefix}-${var.env_short}-${var.location_replica_short}-${var.domain}"
  product         = "${var.prefix}-${var.env_short}"

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
  application_insights_name          = "pagopa-${var.env_short}-appinsights"
  vnet_name                          = "${local.product}-vnet"
  vnet_replica_name                  = "${local.product}-${var.location_replica_short}-core-replica-vnet"
  vnet_resource_group_name           = "${local.product}-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  cosmos_mongo_dns_zone_name          = "privatelink.mongo.cosmos.azure.com"
  cosmos_nosql_dns_zone_name          = "privatelink.documents.azure.com"
  cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  storage_dns_zone_name                = "privatelink.blob.core.windows.net"
  table_dns_zone_name                  = "privatelink.table.core.windows.net"
  storage_dns_zone_resource_group_name = "${local.product}-vnet-rg"
  sb_resource_group_name               = "${local.project}-sb-rg"

  aks_subnet_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"

  evt_hub_location = "weu-core"

}

