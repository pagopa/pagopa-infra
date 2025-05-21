
# product definition
module "apim_ecommerce_jwt_issuer_product" {
  source                = "./.terraform/modules/__v3__/api_management_product"
  product_id            = "ecommerce-jwt-issuer"
  display_name          = "eCommerce JWT issuer service"
  description           = "eCommerce pagoPA product for JWT token issuer service"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000
  policy_xml            = file("./api_product/_base_policy.xml")
}

locals {
  apim_ecommerce_jwt_token_creation_api = {
    display_name          = "eCommerce JWT token issuer service creation"
    description           = "eCommerce JWT token issuer service api - token creation api"
    path                  = "ecommerce/token-service/creation"
    subscription_required = true
    service_url           = null
  }
  apim_ecommerce_jwt_token_validation_api = {
    display_name          = "eCommerce JWT token issuer service validation"
    description           = "eCommerce JWT token issuer service api - token validation api"
    path                  = "ecommerce/token-service/validation"
    subscription_required = false
    service_url           = null
  }
}

#START token creation apis

#version set
resource "azurerm_api_management_api_version_set" "apim_ecommerce_token_creation_api" {
  name                = "${local.project}-ecommerce-jwt-token-creation-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_jwt_token_creation_api.display_name
  versioning_scheme   = "Segment"
}

#api module
module "apim_ecommerce_token_creation_api_v1" {
  source                = "./.terraform/modules/__v3__/api_management_api"
  name                  = "${local.project}-ecommerce-jwt-token-creation-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_jwt_issuer_product.product_id]
  subscription_required = local.apim_ecommerce_jwt_token_creation_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_token_creation_api.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_jwt_token_creation_api.service_url

  description  = local.apim_ecommerce_jwt_token_creation_api.description
  display_name = local.apim_ecommerce_jwt_token_creation_api.display_name
  path         = local.apim_ecommerce_jwt_token_creation_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-jwt-token-issuer/token-issuer-api/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-jwt-token-issuer/token-issuer-api/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}
#END token creation apis

#START token validation apis

#version set
resource "azurerm_api_management_api_version_set" "apim_ecommerce_token_validation_api" {
  name                = "${local.project}-ecommerce-jwt-token-validation-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_jwt_token_validation_api.display_name
  versioning_scheme   = "Segment"
}

#api module
module "apim_ecommerce_token_validation_api_v1" {
  source                = "./.terraform/modules/__v3__/api_management_api"
  name                  = "${local.project}-ecommerce-jwt-token-validation-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_jwt_issuer_product.product_id]
  subscription_required = local.apim_ecommerce_jwt_token_validation_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_token_validation_api.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_jwt_token_validation_api.service_url

  description  = local.apim_ecommerce_jwt_token_validation_api.description
  display_name = local.apim_ecommerce_jwt_token_validation_api.display_name
  path         = local.apim_ecommerce_jwt_token_validation_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-jwt-token-issuer/token-validation-api/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-jwt-token-issuer/token-validation-api/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

#END token validation apis