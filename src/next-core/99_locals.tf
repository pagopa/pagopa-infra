locals {
  product        = "${var.prefix}-${var.env_short}"
  product_region = "${var.prefix}-${var.env_short}-${var.location_short}"
  product_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}"
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}-${var.domain}"

  dns_forwarder_backup_name = "${local.product}-dns-forwarder-backup-vmss"

  soap_basepath_nodo_postgres_pagopa = "nodo"

  azdo_iac_managed_identities   = toset(["azdo-${var.env}-pagopa-iac-deploy", "azdo-${var.env}-pagopa-iac-plan"])
  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"

}
