locals {
  product = "${var.prefix}-${var.env_short}"
  domain  = "synthetic"
  project = "${local.product}-${var.location_short}-${local.domain}"


  monitor_appinsights_name                 = "${local.product}-appinsights"
  monitor_action_group_slack_name          = "SlackPagoPA"
  monitor_action_group_email_name          = "PagoPA"
  monitor_action_group_opsgenie_name       = "Opsgenie"
  monitor_action_group_infra_opsgenie_name = "InfraOpsgenie"
  monitor_resource_group_name              = "${local.product}-monitor-rg"

  vnet_core_resource_group_name               = "${local.product}-vnet-rg"
  vnet_core_name                              = "${local.product}-vnet"
  log_analytics_workspace_name                = "${local.product}-law"
  log_analytics_workspace_resource_group_name = "${local.product}-monitor-rg"

  key_vault_name    = "pagopa-${var.env_short}-kv"
  key_vault_rg_name = "pagopa-${var.env_short}-sec-rg"

}
