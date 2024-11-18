###############
# GPD FOR ACA #
###############

## API ##

resource "azurerm_api_management_api_version_set" "api_debt_positions_for_aca_api" {
  name                = format("%s-debt-positions-for-aca-service-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_debt_positions_for_aca_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_debt_positions_for_aca_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//api_management_api?ref=v6.11.2"

  name                = format("%s-debt-positions-for-aca-service-api", local.product)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids         = [module.apim_aca_product.product_id]

  subscription_required = local.apim_debt_positions_for_aca_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_debt_positions_for_aca_api.id
  api_version           = "v1"

  description  = local.apim_debt_positions_for_aca_service_api.description
  display_name = local.apim_debt_positions_for_aca_service_api.display_name
  path         = local.apim_debt_positions_for_aca_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_debt_positions_for_aca_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/gpd-for-aca-services/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_aca_product.product_id
  })

  xml_content = file("./api/gpd-for-aca-services/v1/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "set_service_type_on_create_gpd_for_aca" {
  api_name              = format("%s-debt-positions-for-aca-service-api-v1", local.product)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  operation_id          = "createPosition"
  xml_content = templatefile("./../gps-app/api/gpd_api/service-type-set.xml", {
    service_type_value = var.service_type_aca
  })
}
