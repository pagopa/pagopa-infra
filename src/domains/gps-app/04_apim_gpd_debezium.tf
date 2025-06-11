####################
## Local variables #
####################

locals {
  apim_gpd_debezium_api = {
    published             = false
    subscription_required = true
    approval_required     = false
    subscriptions_limit   = 1000

    description  = "Api to monitor and manage GPD Debezium Connector"
    display_name = "GPD Debezium API"
    path         = "gpd-debezium/api"
    service_url  = format("https://%s/debezium-gpd", local.gps_hostname)
  }
}

##############
## Products ##
##############

module "apim_gpd_debezium_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-gpd-debezium"
  display_name = "GPD Debezium API pagoPA"
  description  = "Prodotto GPD Debezium API"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = local.apim_gpd_debezium_api.published
  subscription_required = local.apim_gpd_debezium_api.subscription_required
  approval_required     = local.apim_gpd_debezium_api.approval_required
  subscriptions_limit   = local.apim_gpd_debezium_api.subscriptions_limit

  policy_xml = file("./api_product/debezium-api/_base_policy.xml")
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_debezium_api" {

  name                = format("%s-api-gpd-debezium-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_gpd_debezium_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_gpd_debezium_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-api-gpd-debezium-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_debezium_product.product_id]
  subscription_required = local.apim_gpd_debezium_api.subscription_required
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_debezium_api.id
  service_url           = local.apim_gpd_debezium_api.service_url

  description  = local.apim_gpd_debezium_api.description
  display_name = local.apim_gpd_debezium_api.display_name
  path         = local.apim_gpd_debezium_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/debezium-api/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/debezium-api/v1/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
