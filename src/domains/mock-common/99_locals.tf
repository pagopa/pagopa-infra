locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_legacy = "${var.prefix}-${var.env_short}"
  product        = "${var.prefix}-${var.env_short}"


  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  apim_subnet_name = "${var.prefix}-${var.env_short}-apim-snet"

  vnet_resource_group_name = "${var.prefix}-${var.env_short}-vnet-rg"
  vnet_integration_name    = "${var.prefix}-${var.env_short}-vnet-integration"
  vnet_name                = "${var.prefix}-${var.env_short}-vnet"

  monitor_appinsights_name = "${local.product}-appinsights"

}
