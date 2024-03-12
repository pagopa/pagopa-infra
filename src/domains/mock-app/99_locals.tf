locals {
  project          = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product          = "${var.prefix}-${var.env_short}"
  product_location = "${var.prefix}-${var.env_short}-${var.location_short}"
  project_legacy   = "${var.prefix}-${var.env_short}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  monitor_appinsights_name        = "${local.product}-appinsights"

  vnet_name                = "${var.prefix}-${var.env_short}-vnet"
  vnet_resource_group_name = "${var.prefix}-${var.env_short}-vnet-rg"
  pagopa_vnet_integration  = "${var.prefix}-${var.env_short}-vnet-integration"

  subscription_name = "${var.env}-${var.prefix}"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  pagopa_apim_snet = "${local.product}-apim-snet"

  apim_hostname    = "api.${var.dns_zone_prefix}.${var.external_domain}"
  apim_subnet_name = "${var.prefix}-${var.env_short}-apim-snet"

  mock_hostname = "weu${var.env}.mock.internal.${var.env}.platform.pagopa.it"

  mock_kv_rg = "${local.product}-${var.domain}-sec-rg"
  mock_kv    = "${local.product}-${var.domain}-kv"

  mock_ec_default_site_hostname              = "pagopa-${var.env_short}-app-mock-ec.azurewebsites.net"
  mock_payment_gateway_default_site_hostname = "pagopa-${var.env_short}-app-mock-payment-gateway.azurewebsites.net"

  mocker_core_api_locals = {
    product_id            = "mocker"
    display_name          = "Mocker - Core"
    description           = "Generic entrypoint for mocking response for pagoPA platform"
    subscription_required = false
    subscription_limit    = 1000

    path        = "mocker"
    service_url = null

    pagopa_tenant_id = data.azurerm_client_config.current.tenant_id
  }

  mocker_config_api_locals = {
    product_id            = "mocker-config"
    display_name          = "Mocker Configurator"
    description           = "Service for configure resources used by Mocker"
    subscription_required = false
    subscription_limit    = 1000

    path        = "mocker-config"
    service_url = null

    pagopa_tenant_id = data.azurerm_client_config.current.tenant_id
  }

  # Product APIM for Node
  apim_x_node_product_id = "apim_for_node"
}
