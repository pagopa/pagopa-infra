locals {
  project         = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_itn     = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"
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

  vnet_name                = "${local.product}-vnet"
  vnet_replica_name        = "${local.product}-${var.location_replica_short}-core-replica-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  cosmos_dns_zone_name                = "privatelink.documents.azure.com"
  cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  cosmos_table_dns_zone_name                = "privatelink.table.cosmos.azure.com"
  cosmos_table_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  storage_dns_zone_name                = "privatelink.blob.core.windows.net"
  storage_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  aks_subnet_name  = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks-snet"
  azdo_subnet_name = "${local.product}-azdoa-snet"

  common_private_endpoint_snet = "${var.prefix}-${var.env_short}-common-private-endpoint-snet"

  gpd_hostname        = module.postgres_flexible_server_private_db.fqdn
  gpd_dbmsport        = "6432"
  flyway_gpd_dbmsport = "5432"

  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])

  rtp_resource_group_name = "${local.project}-rtp-rg"

  monitor_action_group_infra_opsgenie_name = "InfraOpsgenie"
  monitor_resource_group_name              = "${local.product}-monitor-rg"

  msg_resource_group_name = "${local.product}-msg-rg"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
}
