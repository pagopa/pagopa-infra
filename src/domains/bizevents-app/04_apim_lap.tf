data "azurerm_key_vault_secret" "list_lap_for_io_api_key_secret" {
  name         = "list-lap-4-io-api-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "list_lap_for_io_api_key_secret" {
  name                = "list-lap-for-io-api-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "list-lap-for-io-api-key"
  value               = data.azurerm_key_vault_secret.list_lap_for_io_api_key_secret.value
  secret              = true
}


#####################################
##    API LAP                      ##
#####################################
locals {
  apim_lap_service_api = { // AppIO
    display_name          = "Biz Events LAP Service"
    description           = "API to handle biz events LAP"
    path                  = "bizevents/notices-service"
    subscription_required = true
    service_url           = null
  }
}

##############
## Products ##
##############


module "apim_lap_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "bizevent-lap"
  display_name = local.apim_lap_service_api.display_name
  description  = local.apim_lap_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_lap_service_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/lap-service/_base_policy.xml")
}


##############
## Api Vers ##
##############

resource "azurerm_api_management_api_version_set" "api_bizevents_lap_api" {

  name                = format("%s-bizevents-lap-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_lap_service_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api_version_set" "api_bizevents_lap_jwt_api" {

  name                = format("%s-bizevents-lap-service-api-jwt", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "${local.apim_lap_service_api.display_name} JWT"
  versioning_scheme   = "Segment"
}


##############
## OpenApi  ##
##############

module "apim_api_bizevents_lap_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-bizevents-lap-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = var.env_short == "p" ? [module.apim_lap_product.product_id] : [module.apim_lap_product.product_id, module.apim_bizevents_product.product_id, module.apim_bizevents_product_all_in_one[0].product_id]
  subscription_required = local.apim_lap_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_bizevents_lap_api.id
  api_version           = "v1"

  description  = local.apim_lap_service_api.description
  display_name = local.apim_lap_service_api.display_name
  path         = local.apim_lap_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_lap_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/lap-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/lap-service/v1/_base_policy.xml", {
    hostname = local.bizevents_hostname
  })
}

module "apim_api_bizevents_lap_api_jwt_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = format("%s-bizevents-lap-service-api-jwt", local.project)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  product_ids         = [module.apim_lap_product.product_id]
  # subscription_required = local.apim_lap_service_api.subscription_required
  subscription_required = false # use jwt
  version_set_id        = azurerm_api_management_api_version_set.api_bizevents_lap_api.id
  api_version           = "v1"

  description  = "${local.apim_lap_service_api.description} JWT"
  display_name = "${local.apim_lap_service_api.display_name} JWT"
  path         = "${local.apim_lap_service_api.path}-jwt"
  protocols    = ["https"]
  service_url  = local.apim_lap_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/lap-service/v1/_openapi-jwt.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/lap-service/v1/_base_policy-jwt.xml", {
    hostname          = local.bizevents_hostname
    pdv_api_base_path = var.pdv_api_base_path
  })
}


resource "azurerm_api_management_api_operation_policy" "policy_lap_generatePDF" { #

  api_name            = module.apim_api_bizevents_lap_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "generatePDF"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/lap-service/v1/lap_generatePDF.xml.tpl", {
    guard-lock-duration = 60
  })
}

resource "azurerm_api_management_api_operation_policy" "policy_lap_generatePDF_jwt" { #

  api_name            = module.apim_api_bizevents_lap_api_jwt_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "generatePDF"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/lap-service/v1/lap_generatePDF.xml.tpl", {
    guard-lock-duration = 60
  })
}

# API policy SHA
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_policy_lap_generatePDF" {
  input = sha256(templatefile("./api/lap-service/v1/lap_generatePDF.xml.tpl", {
    guard-lock-duration = 60
  }))
}
