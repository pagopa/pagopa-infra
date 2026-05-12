locals {
  product       = "${var.prefix}-${var.env_short}"
  product_italy = "${var.prefix}-${var.env_short}-${var.location_short}"
  project_short = "${var.prefix}-${var.env_short}-${var.domain}"
  project       = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  project_core_itn = "${var.prefix}-${var.env_short}-${var.location_short}-core"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_appinsights_italy_name  = "${local.project_core_itn}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_core_resource_group_name  = "${local.product}-vnet-rg"

  aks_subnet_name    = "${local.product}-${var.location_short}-${var.env}-user-aks"
  cosmos_subnet_name = "${local.product}-${var.location_short}-${var.env}-user-aks"

  vnet_spoke_data_name      = "${local.product_italy}-spoke-data-vnet"
  vnet_hub_spoke_rg_name    = "${local.product_italy}-network-hub-spoke-rg"
  vnet_spoke_streaming_name = "${local.product_italy}-spoke-streaming-vnet"

  ingress_hostname = "${var.location_short}.${var.domain}"

  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  cosmos_dns_zone_name                = "privatelink.mongo.cosmos.azure.com"
  cosmos_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
  azdo_iac_managed_identities = toset(
    ["azdo-${var.env}-pagopa-iac-deploy",
    "azdo-${var.env}-pagopa-iac-plan"]
  )

  msg_resource_group_name      = "${local.product}-msg-rg"
  eventhub_resource_group_name = "${local.project}-evh-rg"
}
