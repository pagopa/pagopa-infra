locals {
  project                               = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product                               = "${var.prefix}-${var.env_short}"
  monitor_appinsights_name              = "${local.product}-appinsights"
  ingress_hostname                      = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"
  pagopa_apim_name                      = "${local.product}-apim"
  pagopa_apim_rg                        = "${local.product}-api-rg"

  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])

  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"

  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
}
