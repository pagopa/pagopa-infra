##############
## Products ##
##############

module "apim_qi_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "qi"
  display_name = "QI pagoPA"
  description  = "Product for Quality Improvement pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################################################
## API QI service                          ##
#################################################
locals {
  apim_qi_api = {
    display_name          = "pagoPA - Quality Improvement API"
    description           = "API for Quality Improvement service"
    path                  = "qi"
    subscription_required = true
    service_url           = null
  }
}

# qi service APIs
resource "azurerm_api_management_api_version_set" "qi_api" {
  name                = format("%s-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_qi_api.display_name
  versioning_scheme   = "Segment"
}

# module "apim_qi_api_v1" {
#   source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

#   name                  = format("%s-api", local.project)
#   api_management_name   = local.pagopa_apim_name
#   resource_group_name   = local.pagopa_apim_rg
#   product_ids           = [module.apim_qi_product.product_id]
#   subscription_required = local.apim_qi_api.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.qi_api.id
#   api_version           = "v1"

#   description  = local.apim_qi_api.description
#   display_name = local.apim_qi_api.display_name
#   path         = local.apim_qi_api.path
#   protocols    = ["https"]
#   service_url  = local.apim_qi_api.service_url

#   content_format = "openapi"
#   content_value = templatefile("./api/qi/v1/_openapi.json.tpl", {
#     hostname = local.apim_hostname
#   })

#   xml_content = templatefile("./api/qi/v1/_base_policy.xml.tpl", {
#     hostname = local.qi_hostname
#   })
# }


resource "azurerm_api_management_api" "apim_qi_v1" {
  name                  = format("%s-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_qi_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.qi_api.id
  version               = "v1"
  revision              = "1"

  description  = local.apim_qi_api.description
  display_name = local.apim_qi_api.display_name
  path         = local.apim_qi_api.path
  protocols    = ["https"]
  service_url  = local.apim_qi_api.service_url

  subscription_key_parameter_names {
    header = "Authorization"
    query  = "auth-key"
  }

  import {
    content_format = "openapi"
    content_value = templatefile("./api/qi/v1/_openapi.json.tpl", {
      hostname = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_qi_product_api" {
  api_name            = azurerm_api_management_api.apim_qi_v1.name
  product_id          = module.apim_qi_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_qi_api_policy" {
  api_name            = azurerm_api_management_api.apim_qi_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = templatefile("./api/qi/v1/_base_policy.xml.tpl", {
    hostname = local.qi_hostname
  })
}
