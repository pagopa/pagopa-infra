locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_itn    = "${var.prefix}-${var.env_short}-${var.location_short_itn}-${var.domain}"
  project_legacy = "${var.prefix}-${var.env_short}"
  product        = "${var.prefix}-${var.env_short}"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  pagopa_apim_snet = "${local.product}-apim-snet"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  storage_blob_dns_zone_name       = "privatelink.blob.core.windows.net"
  storage_blob_resource_group_name = "${local.product}-vnet-rg"

  msg_resource_group_name      = "${local.product}-msg-rg"
  eventhub_resource_group_name = "${local.project_itn}-evh-rg"

  vnet_italy_name                = "${local.product}-itn-vnet"
  vnet_italy_resource_group_name = "${local.product}-itn-vnet-rg"
}
