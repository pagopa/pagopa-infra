locals {
  product     = "${var.prefix}-${var.env_short}"
  product_ita = "${var.prefix}-${var.env_short}-${var.location_short}"
  project     = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  # peerings
  vnet_core_name                = "${local.product}-vnet"
  vnet_core_resource_group_name = "${local.product}-vnet-rg"

  vnet_integration_name                = "${local.product}-vnet-integration"
  vnet_integration_resource_group_name = "${local.product}-vnet-rg"

  cstar_vnet_rg_name = "cstar-${var.env_short}-itn-core-network-rg"
  cstar_vnet_name    = "cstar-${var.env_short}-itn-core-spoke-compute-vnet"

  cstar_weu_vnet_rg_name = "cstar-${var.env_short}-weu-${var.env}01-vnet-rg"
  cstar_weu_vnet_name    = "cstar-${var.env_short}-weu-${var.env}01-vnet"

  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])
  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
}
