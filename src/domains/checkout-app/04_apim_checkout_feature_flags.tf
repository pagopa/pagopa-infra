locals {
  apim_checkout_feature_flags = {
    display_name          = "Checkout pagoPA feature Flags"
    description           = "This APIM level API is used to enable feature flags features in checkout."
    path                  = "checkout/feature-flags"
    subscription_required = false
    service_url           = null
  }
}

module "apim_checkout_featureflags" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "checkout-feature-flags"
  display_name = "Checkout Feature flags"
  description  = "This API set contains APIM level apis used to manage feature flags for checkout."

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/checkout-authentication/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "checkout_feature_flags_api_v1" {
  name                = "${local.project_short}-feature-flags-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_feature_flags.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_feature_flags_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project_short}-feature-flags-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_featureflags.product_id]
  subscription_required = local.apim_checkout_feature_flags.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_feature_flags_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_feature_flags.service_url

  description  = local.apim_checkout_feature_flags.description
  display_name = local.apim_checkout_feature_flags.display_name
  path         = local.apim_checkout_feature_flags.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_feature_flags/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_feature_flags/v1/_base_policy.xml.tpl", {
    checkout_origin = "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}

resource "azurerm_api_management_named_value" "apim_checkout_feature_flags_ipwhitelist_value" {
  name                = "enable-authentication-ip-whitelist"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "enable-authentication-ip-whitelist"
  value               = "-"
  secret              = true
  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

#######################################################################
## Fragment policy to filter feature flags based on different rules  ##
#######################################################################

resource "azurerm_api_management_policy_fragment" "fragment_checkout_feature_flag_filter" {
  api_management_id = data.azurerm_api_management.apim.id
  name              = "fragment-checkout-feature-flag-filter"
  format            = "rawxml"
  value = templatefile("./api/fragments/_fragment_feature_flag_filter.tpl.xml", {
  })
}
