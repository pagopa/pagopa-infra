data "azurerm_key_vault_secret" "ecommerce_webview_jwt_signing_key" {
  name         = "ecommerce-io-jwt-signing-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "ecommerce-webview-jwt-signing-key" {
  name                = "ecommerce-webview-jwt-signing-key"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ecommerce-webview-jwt-signing-key"
  value               = data.azurerm_key_vault_secret.ecommerce_webview_jwt_signing_key.value
  secret              = true
}

##############
## Products ##
##############

module "apim_ecommerce_webview_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "ecommerce-webview"
  display_name = "eCommerce for webview"
  description  = "eCommerce pagoPA product dedicated to webview"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

# pagopa-ecommerce APIs for io
locals {
  apim_ecommerce_webview_api = {
    display_name          = "eCommerce API for webview"
    description           = "eCommerce pagoPA API dedicated to webview for pagoPA payment"
    path                  = "ecommerce/webview"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_webview_api" {
  name                = "${local.project}-ecommerce-webview-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_webview_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_webview_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-ecommerce-webview-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_webview_product.product_id]
  subscription_required = local.apim_ecommerce_webview_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_webview_api.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_webview_api.service_url

  description  = local.apim_ecommerce_webview_api.description
  display_name = local.apim_ecommerce_webview_api.display_name
  path         = local.apim_ecommerce_webview_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-webview/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-webview/v1/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}

module "apim_ecommerce_webview_api_v2" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-ecommerce-webview-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_webview_product.product_id]
  subscription_required = local.apim_ecommerce_webview_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_webview_api.id
  api_version           = "v2"
  service_url           = local.apim_ecommerce_webview_api.service_url

  description  = local.apim_ecommerce_webview_api.description
  display_name = local.apim_ecommerce_webview_api.display_name
  path         = local.apim_ecommerce_webview_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-webview/v2/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-webview/v2/_base_policy.xml.tpl", {
    ecommerce_ingress_hostname = local.ecommerce_hostname
  })
}
