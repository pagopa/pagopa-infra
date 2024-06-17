locals {
  project          = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product          = "${var.prefix}-${var.env_short}"
  product_location = "${var.prefix}-${var.env_short}-${var.location_short}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  pagopa_apim_v2_name = "${local.product_location}-core-apim-v2"
  pagopa_apim_v2_rg   = "${local.product}-api-rg"

}
