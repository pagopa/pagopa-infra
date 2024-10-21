locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"

  aks_name                = "${local.product}-${var.location_short}-dev-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-dev-aks-rg"

  apisix_admin_base_path = "${var.apisix_admin_host}/apisix/admin"

  apisix_hostname = "weu${var.env}.apisix.internal.${var.env_short == "p" ? "" : "${var.env}."}platform.pagopa.it"
}
