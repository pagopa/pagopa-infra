locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product        = "${var.prefix}-${var.env_short}"
  parent_project = "${var.prefix}-${var.env_short}"
  project_short  = "${var.prefix}-${var.env_short}-${var.domain}"

  monitor_appinsights_name           = "${local.product}-appinsights"
  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "PaymentManagerOpsgenie"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"

  log_analytics_workspace_name                = "pagopa-${var.env_short}-law"
  log_analytics_workspace_resource_group_name = "pagopa-${var.env_short}-monitor-rg"

  checkout_hostname = "${var.location_short}${var.env}.checkout.internal.${var.apim_dns_zone_prefix}.${var.external_domain}"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  payment_wallet_hostname = "itn${var.env}.pay-wallet.internal.${var.apim_dns_zone_prefix}.${var.external_domain}"
}
