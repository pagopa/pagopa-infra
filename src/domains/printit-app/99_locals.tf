locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  monitor_appinsights_name        = "${local.product}-appinsights"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname       = "${var.domain}.itn"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  pagopa_vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  pagopa_vnet_rg          = "pagopa-${var.env_short}-vnet-rg"

  domain_hostname = "${var.dns_zone_prefix}.${local.internal_dns_zone_name}"

}
