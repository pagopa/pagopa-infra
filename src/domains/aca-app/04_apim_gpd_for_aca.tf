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
  source = "./.terraform/modules/__v3__/api_management_api"

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
  // the content value is the GPD API v1
  content_value = templatefile("./api/aca-gpd-like/v1/_openapi.json.tpl", {
    service = module.apim_aca_product.product_id
  })

  xml_content = file("./api/aca-gpd-like/v1/_base_policy.xml")
}

###################################
## CREATE DEBT POSITION POLICY ####
###################################

resource "terraform_data" "sha256_create_debt_position_v1_policy" {
  input = sha256(file("./../gps-app/api/gpd_api/debt-position-services/create_base_policy.xml"))
}

resource "azurerm_api_management_api_operation_policy" "create_debt_position_v1_policy" {
  api_name            = format("%s-debt-positions-for-aca-service-api-v1", local.product)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "createPosition"
  xml_content = templatefile("./../gps-app/api/gpd_api/debt-position-services/create_base_policy.xml", {
    service_type_value = "ACA"
  })
}
