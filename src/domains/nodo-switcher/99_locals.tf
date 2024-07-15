locals {
  project          = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product          = "${var.prefix}-${var.env_short}"
  product_location = "${var.prefix}-${var.env_short}-${var.location_short}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
}
