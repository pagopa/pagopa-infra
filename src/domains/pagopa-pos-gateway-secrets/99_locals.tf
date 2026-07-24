locals {
  domain        = "pagopa-pos-gateway"
  domain_short  = "ppg"
  prefix        = "pagopa"
  project       = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain}"
  project_short = "${local.prefix}-${var.env_short}-${var.location_short}-${local.domain_short}"
  product       = "${local.prefix}-${var.env_short}"


  subscription_name = "${var.env}-${local.prefix}"

  azdo_managed_identity_rg_name = ""
  azdo_iac_managed_identities   = toset(["-deploy", "-plan"])

}
