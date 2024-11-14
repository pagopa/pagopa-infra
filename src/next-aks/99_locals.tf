locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  monitor_resource_group_name     = "pagopa-${var.env_short}-monitor-rg"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  key_vault_name    = "pagopa-${var.env_short}-kv"
  key_vault_rg_name = "pagopa-${var.env_short}-sec-rg"

  aks_name = "${local.project}-aks"
}
