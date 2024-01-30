locals {
  project = "${var.prefix}-${var.env_short}"

  apim_x_node_product_id = "apim_for_node"

  soap_basepath_nodo_postgres_pagopa = "nodo"

  azdo_managed_identity_name    = "${var.env}-pagopa"
  azdo_managed_identity_rg_name = "pagopa-${var.env_short}-identity-rg"
}
