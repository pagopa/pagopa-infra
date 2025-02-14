locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  subscription_name = "${var.env}-${var.prefix}"

  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])

}
