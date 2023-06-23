locals {
  project        = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  project_legacy = "${var.prefix}-${var.env_short}"
  product        = "${var.prefix}-${var.env_short}"

  apim_hostname    = "api.${var.dns_zone_prefix}.${var.external_domain}"
  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  apim_subnet_name = "${var.prefix}-${var.env_short}-apim-snet"

  vnet_resource_group_name = "${var.prefix}-${var.env_short}-vnet-rg"
  vnet_integration_name    = "${var.prefix}-${var.env_short}-vnet-integration"
  vnet_name                = "${var.prefix}-${var.env_short}-vnet"

  monitor_appinsights_name = "${local.product}-appinsights"


  mock_ec_default_site_hostname              = "pagopa-${var.env_short}-app-mock-ec.azurewebsites.net"
  mock_payment_gateway_default_site_hostname = "pagopa-${var.env_short}-app-mock-payment-gateway.azurewebsites.net"
}
