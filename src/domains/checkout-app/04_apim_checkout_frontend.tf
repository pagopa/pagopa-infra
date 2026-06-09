##############
## Products ##
##############

module "apim_checkout_frontend_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "checkout-frontend"
  display_name = "Checkout Frontend Proxy"
  description  = "APIM proxy for checkout frontend via App Gateway - serves as fallback path for Front Door CDN"

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/checkout-frontend/_base_policy.xml")
}

locals {
  apim_checkout_frontend = {
    display_name          = "Checkout Frontend Proxy"
    description           = "Reverse proxy for checkout frontend served by Front Door CDN - used during migration and retained as fallback"
    path                  = "checkout-fe"
    subscription_required = false
    service_url           = null
  }

  # NPG SDK hostname (same as in CDN config)
  checkout_frontend_npg_sdk_hostname = local.npg_sdk_hostname

  # Front Door endpoint hostname (referenced from the CDN module)
  checkout_frontend_fd_hostname = module.checkout_cdn_frontdoor.fqdn
}

module "apim_checkout_frontend_api" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.parent_project}-checkout-frontend-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_frontend_product.product_id]
  subscription_required = local.apim_checkout_frontend.subscription_required
  service_url           = local.apim_checkout_frontend.service_url

  description  = local.apim_checkout_frontend.description
  display_name = local.apim_checkout_frontend.display_name
  path         = local.apim_checkout_frontend.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_frontend/v1/_openapi.json.tpl", {
    host = local.checkout_fe_apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_frontend/v1/_base_policy.xml.tpl", {
    storage_web_hostname = module.checkout_cdn_frontdoor.storage_primary_web_host
    csp_value            = local.checkout_csp_value
    checkout_fe_hostname = local.checkout_fe_apim_hostname
  })
}

#####################################
## Fonts operation policy (NPG)    ##
#####################################

resource "azurerm_api_management_api_operation_policy" "checkout_frontend_get_fonts" {
  api_name            = "${local.parent_project}-checkout-frontend-api"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "checkoutFrontendGetFonts"

  xml_content = templatefile("./api/checkout/checkout_frontend/v1/_get_fonts_policy.xml.tpl", {
    npg_sdk_hostname     = local.checkout_frontend_npg_sdk_hostname
    checkout_fe_hostname = local.checkout_fe_apim_hostname
  })

  depends_on = [module.apim_checkout_frontend_api]
}
