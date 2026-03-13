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
  checkout_frontend_npg_sdk_hostname = var.env_short == "p" ? "xpay.nexigroup.com" : "stg-ta.nexigroup.com"

  # Front Door endpoint hostname (referenced from the CDN module)
  checkout_frontend_fd_hostname = module.checkout_cdn_frontdoor.fqdn

  # Content-Security-Policy from CDN delivery rules
  # full CSP value, combines all overwrite and append actions from the CDN config
  checkout_frontend_csp_value = join("", [
    # Rule 1 - overwrite (base)
    format(
      "default-src 'self'; connect-src 'self' https://api.%s.%s https://api-eu.mixpanel.com https://privacyportalde-cdn.onetrust.com https://privacyportal-de.onetrust.com",
      var.dns_zone_prefix,
      var.external_domain
    ),
    # rule 1 - append (recaptcha connect-src)
    " https://recaptcha.net/;",
    # rule 1 - append (frame-ancestors, object-src, frame-src)
    "frame-ancestors 'none'; object-src 'none'; frame-src 'self' https://www.google.com *.platform.pagopa.it *.nexigroup.com *.recaptcha.net recaptcha.net https://recaptcha.google.com;",
    # rule 2 - append (img-src)
    "img-src 'self' https://assets.cdn.io.italia.it www.gstatic.com/recaptcha data: https://assets.cdn.platform.pagopa.it https://privacyportalde-cdn.onetrust.com;",
    # rule 2 - append (script-src)
    format(
      "script-src 'self' 'sha256-LIYUdRhA1kkKYXZ4mrNoTMM7+5ehEwuxwv4/FRhgems=' https://www.google.com https://www.gstatic.com https://www.recaptcha.net https://recaptcha.net https://www.gstatic.com/recaptcha/ https://www.gstatic.cn/recaptcha/ https://privacyportalde-cdn.onetrust.com https://%s;",
      local.checkout_frontend_npg_sdk_hostname
    ),
    # rule 2 - append (style-src, font-src, worker-src)
    "style-src 'self'  'unsafe-inline' https://privacyportalde-cdn.onetrust.com; font-src 'self' https://privacyportalde-cdn.onetrust.com; worker-src www.recaptcha.net blob:;"
  ])
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
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_frontend/v1/_base_policy.xml.tpl", {
    frontdoor_endpoint_hostname = local.checkout_frontend_fd_hostname
    npg_sdk_hostname            = local.checkout_frontend_npg_sdk_hostname
    csp_value                   = local.checkout_frontend_csp_value
  })
}
