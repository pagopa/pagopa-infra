##############################################
## Data sources for cross-domain references ##
##############################################

data "azurerm_storage_account" "wallet_cdn_frontdoor_sa" {
  name                = "${replace(local.project, "-", "")}cdnsa"
  resource_group_name = "${local.project}-fe-rg"
}

##############
## Products ##
##############

module "apim_wallet_frontend_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "wallet-frontend"
  display_name = "Wallet Frontend Proxy"
  description  = "APIM proxy for wallet frontend via App Gateway - serves as fallback path for Front Door CDN"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/_base_policy.xml")
}

locals {
  apim_wallet_frontend = {
    display_name          = "Wallet Frontend Proxy"
    description           = "Reverse proxy for wallet frontend served by Front Door CDN - used during migration and retained as fallback"
    path                  = "wallet-fe"
    subscription_required = false
    service_url           = null
  }

  wallet_frontend_npg_sdk_hostname = var.env_short == "p" ? "xpay.nexigroup.com" : "stg-ta.nexigroup.com"

  wallet_csp_value = join("", [
    "default-src 'self'; connect-src 'self' *.platform.pagopa.it *.pagopa.gov.it *.nexigroup.com;",
    " frame-ancestors 'none'; object-src 'none'; frame-src 'self' *.platform.pagopa.it *.nexigroup.com;",
    " img-src 'self' https://assets.cdn.io.italia.it *.platform.pagopa.it data:;",
    " script-src 'self' 'unsafe-inline' *.nexigroup.com;",
    " style-src 'self' 'unsafe-inline'; worker-src blob:;"
  ])
}

module "apim_wallet_frontend_api" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-wallet-frontend-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_wallet_frontend_product.product_id]
  subscription_required = local.apim_wallet_frontend.subscription_required
  service_url           = local.apim_wallet_frontend.service_url

  description  = local.apim_wallet_frontend.description
  display_name = local.apim_wallet_frontend.display_name
  path         = local.apim_wallet_frontend.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/wallet-frontend/v1/_openapi.json.tpl", {
    host = local.wallet_fe_apim_hostname
  })

  xml_content = templatefile("./api/wallet-frontend/v1/_base_policy.xml.tpl", {
    storage_web_hostname = data.azurerm_storage_account.wallet_cdn_frontdoor_sa.primary_web_host
    csp_value            = local.wallet_csp_value
    wallet_fe_hostname   = local.wallet_fe_apim_hostname
  })
}

#####################################
## Fonts operation policy (NPG)    ##
#####################################

resource "azurerm_api_management_api_operation_policy" "wallet_frontend_get_fonts" {
  api_name            = "${local.project}-wallet-frontend-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  operation_id        = "walletFrontendGetFonts"

  xml_content = templatefile("./api/wallet-frontend/v1/_get_fonts_policy.xml.tpl", {
    npg_sdk_hostname   = local.wallet_frontend_npg_sdk_hostname
    wallet_fe_hostname = local.wallet_fe_apim_hostname
  })

  depends_on = [module.apim_wallet_frontend_api]
}

######################################
## Feature flag: APIM frontend      ##
######################################

resource "azurerm_api_management_named_value" "wallet_apim_frontend_enabled" {
  name                = "wallet-apim-frontend-enabled"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "wallet-apim-frontend-enabled"
  value               = var.wallet_apim_frontend_enabled
}
