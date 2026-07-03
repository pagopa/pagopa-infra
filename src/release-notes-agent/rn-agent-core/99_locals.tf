
locals {
  product = "${var.prefix}-${var.env_short}"

  apim_snet        = "${local.product}-apim-snet"
  vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  vnet_rg          = "pagopa-${var.env_short}-vnet-rg"
}
