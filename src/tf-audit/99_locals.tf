locals {
  prefix  = "pagopa"
  product = "${local.prefix}-${var.env_short}"
  domain  = "tfaudit"
  project = "${local.product}-${var.location_short}-${local.domain}"

  key_vault_name    = "pagopa-${var.env_short}-kv"
  key_vault_rg_name = "pagopa-${var.env_short}-sec-rg"

}
