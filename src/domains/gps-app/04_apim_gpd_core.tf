####################
# GPD INTERNAL USE #
####################

## Products ##

module "apim_gpd_product" {
  source       = "./.terraform/modules/__v3__/api_management_product"
  product_id   = "product-gpd"
  display_name = "GPD pagoPA"
  description  = "Prodotto Gestione Posizione Debitorie"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/gpd/_base_policy.xml")
}

## API ##

module "apim_api_gpd_api" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-api-gpd-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids = concat([module.apim_gpd_product.product_id],
  var.env_short == "-" ? [] : [module.apim_gpd_payments_pull_product_and_debt_positions_product_test[0].product_id]) # ppull-prod-test

  subscription_required = false
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_api.id
  service_url           = local.gpd_core_service_url

  description  = "Api Gestione Posizione Debitorie"
  display_name = "GPD pagoPA"
  path         = "gpd/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/v1/_openapi.json.tpl", {
    service = module.apim_gpd_product.product_id
  })

  xml_content = file("./api/gpd_api/v1/_base_policy.xml")
}

module "apim_api_gpd_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = "${var.env_short}-api-gpd-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids = concat([module.apim_gpd_product.product_id],
  var.env_short == "-" ? [] : [module.apim_gpd_payments_pull_product_and_debt_positions_product_test[0].product_id]) # ppull-prod-test

  subscription_required = false
  api_version           = "v2"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_api.id
  service_url           = local.gpd_core_service_url

  description  = "Api Gestione Posizione Debitorie"
  display_name = "GPD pagoPA"
  path         = "gpd/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/v2/_openapi.json.tpl", {
    service = module.apim_gpd_product.product_id
  })

  xml_content = file("./api/gpd_api/v2/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "api_gpd_api" {
  name                = format("%s-api-gpd-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "Gestione Posizione Debitorie"
  versioning_scheme   = "Segment"
}

####################
# GPD EXTERNAL USE #
####################

## Products ##

module "apim_debt_positions_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "debt-positions"
  display_name = "GPD Debt Positions for organizations"
  description  = "GPD Debt Positions for organizations"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd/debt-position-services/_base_policy.xml")
}

## API ##

resource "azurerm_api_management_api_version_set" "api_debt_positions_api" {
  name                = format("%s-debt-positions-service-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_debt_positions_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_debt_positions_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-debt-positions-service-api", local.product)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids         = [module.apim_debt_positions_product.product_id, module.apim_aca_integration_product.product_id, module.apim_gpd_integration_product.product_id]

  subscription_required = local.apim_debt_positions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_debt_positions_api.id
  api_version           = "v1"

  description  = local.apim_debt_positions_service_api.description
  display_name = local.apim_debt_positions_service_api.display_name
  path         = local.apim_debt_positions_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_debt_positions_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/debt-position-services/v1/_openapi.json.tpl", {
    service = module.apim_debt_positions_product.product_id
  })

  xml_content = file("./api/gpd_api/debt-position-services/_base_policy.xml")
}

module "apim_api_debt_positions_api_v2" {
  count  = var.env_short != "p" ? 1 : 0 # disbled v2 external bulk prod
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-debt-positions-service-api", local.product)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_debt_positions_product.product_id, module.apim_gpd_integration_product.product_id]
  subscription_required = local.apim_debt_positions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_debt_positions_api.id
  api_version           = "v2"

  description  = local.apim_debt_positions_service_api.description
  display_name = local.apim_debt_positions_service_api.display_name
  path         = local.apim_debt_positions_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_debt_positions_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/debt-position-services/v2/_openapi.json.tpl", {
    service = module.apim_debt_positions_product.product_id
  })
  // warning: ad-hoc base policy because there is a rewrite URI
  xml_content = file("./api/gpd_api/debt-position-services/v2/_base_policy.xml")
}

module "apim_api_debt_positions_api_v3" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-debt-positions-service-api", local.product)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids         = [module.apim_debt_positions_product.product_id, module.apim_gpd_integration_product.product_id]

  subscription_required = local.apim_debt_positions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_debt_positions_api.id
  api_version           = "v3"

  description  = local.apim_debt_positions_service_api.description
  display_name = local.apim_debt_positions_service_api.display_name
  path         = local.apim_debt_positions_service_api.path
  protocols    = ["https"]
  service_url  = "${local.apim_debt_positions_service_api.service_url}/v3"

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/debt-position-services/v3/_openapi.json.tpl", {
    service = module.apim_debt_positions_product.product_id
  })

  xml_content = file("./api/gpd_api/debt-position-services/_base_policy.xml")
}

#########################################
## GPD CREATE DEBT POSITION POLICIES ####
#########################################

resource "terraform_data" "sha256_create_debt_position_v1_policy" {
  input = sha256(file("./api/gpd_api/debt-position-services/create_base_policy.xml"))
}

resource "azurerm_api_management_api_operation_policy" "create_debt_position_v1_policy" {
  api_name            = format("%s-debt-positions-service-api-v1", local.product)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "createPosition"
  xml_content = templatefile("./api/gpd_api/debt-position-services/create_base_policy.xml", {
    service_type_value = "GPD"
  })
}

resource "terraform_data" "sha256_create_debt_position_v2_policy" {
  count = var.env_short != "p" ? 1 : 0 # disbled v2 external bulk prod

  input = sha256(file("./api/gpd_api/debt-position-services/create_base_policy.xml"))
}

resource "azurerm_api_management_api_operation_policy" "create_debt_position_v2_policy" {
  count = var.env_short != "p" ? 1 : 0 # disbled v2 external bulk prod

  api_name            = format("%s-debt-positions-service-api-v2", local.product)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "createMultiplePositions"
  xml_content = templatefile("./api/gpd_api/debt-position-services/create_base_policy.xml", {
    service_type_value = "GPD"
  })
}

#####################
## GPD FRAGMENTS ####
#####################

# service type fragment
resource "terraform_data" "sha256_service_type_set_fragment" {
  input = sha256(file("./api/gpd_api/service_type_set_fragment.xml"))
}

resource "azapi_resource" "service_type_set_fragment" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "service-type-set"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that is used to set service type in GPD"
      format      = "rawxml"
      value       = templatefile("./api/gpd_api/service_type_set_fragment.xml", {})
    }
  })
}

# segregation codes fragment
resource "terraform_data" "sha256_segregation_codes_fragment" {
  input = sha256(file("./api/gpd_api/segregation_codes_fragment.xml"))
}

resource "azapi_resource" "segregation_codes_fragment" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "segregation-codes-gpd"
  parent_id = data.azurerm_api_management.apim.id

  body = jsonencode({
    properties = {
      description = "Component that is authorize on segregation codes"
      format      = "rawxml"
      value       = templatefile("./api/gpd_api/segregation_codes_fragment.xml", {})
    }
  })
}

