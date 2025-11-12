locals {
  domain        = "mydomain"
  prefix       = "pagopa"
  project = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain}"
  product = "${local.prefix}-${var.env_short}"


  subscription_name = "${var.env}-${local.prefix}"

  azdo_managed_identity_rg_name = "${local.product}-identity-rg"
  azdo_iac_managed_identities   = toset(["azdo-${var.env}-${local.prefix}-iac-deploy", "azdo-${var.env}-${local.prefix}-iac-plan"])

}
