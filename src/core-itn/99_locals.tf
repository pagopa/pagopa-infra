locals {
  product     = "${var.prefix}-${var.env_short}"
  product_ita = "${var.prefix}-${var.env_short}-${var.location_short_ita}"
  project     = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"

  monitor_appinsights_name        = "${local.product}-appinsights"
  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"

  vnet_name                = "${var.prefix}-${var.env_short}-${var.location_short}-vnet"
  vnet_resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-vnet-rg"

  # peerings
  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  vnet_integration_name                = "${local.product}-vnet-integration"
  vnet_integration_resource_group_name = "${local.product}-vnet-rg"

  vnet_replica_name                = "${local.product}-neu-core-replica-vnet"
  vnet_replica_resource_group_name = "${local.product}-vnet-rg"

  cstar_vnet_rg_name = "cstar-${var.env_short}-itn-core-network-rg"
  cstar_vnet_name    = "cstar-${var.env_short}-itn-core-spoke-compute-vnet"

  cstar_weu_vnet_rg_name = "cstar-${var.env_short}-weu-${var.env}01-vnet-rg"
  cstar_weu_vnet_name    = "cstar-${var.env_short}-weu-${var.env}01-vnet"

  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])
  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
}
