##############
## Products ##
##############

locals {
  apim_app_forwarder_api = {
    display_name          = "pagoPA App Forwarder API"
    description           = "pagoPA App Forwarder API"
    path                  = "pagopa-app-forwarder/api"
    subscription_required = true
    service_url           = null
  }
}

module "apim_app_forwarder_product" {
  count = var.app_forwarder_enabled ? 1 : 0

  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "product-app-forwarder"
  display_name = "Product ${local.apim_app_forwarder_api.display_name}"
  description  = "Product ${local.apim_app_forwarder_api.description}"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 100

  policy_xml = file("./api_product/app_forwarder_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "app_forwarder_api" {
  count = var.app_forwarder_enabled ? 1 : 0

  name                = "${var.env_short}-app-forwarder-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_app_forwarder_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_app_forwarder_api" {
  count = var.app_forwarder_enabled ? 1 : 0

  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${var.env_short}-app-forwarder-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_app_forwarder_product[0].product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.app_forwarder_api[0].id
  api_version    = "v1"

  display_name = local.apim_app_forwarder_api.display_name
  description  = local.apim_app_forwarder_api.description

  path      = local.apim_app_forwarder_api.path
  protocols = ["https"]

  service_url = "https://${module.app_forwarder_app_service[0].default_site_hostname}"

  content_format = "openapi"
  content_value = templatefile("./api/app_forwarder_api/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/app_forwarder_api/v1/_base_policy.xml", {
    app_forwarder_host_path = "https://${module.app_forwarder_app_service[0].default_site_hostname}"
  })

  depends_on = [
    module.app_forwarder_app_service
  ]

}


# ApiKey section 
resource "azurerm_api_management_subscription" "apim_app_forwarder_subkey" {
  count = var.app_forwarder_enabled ? 1 : 0

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = module.apim_app_forwarder_product[0].id
  display_name  = "SMO ${local.apim_app_forwarder_api.display_name}"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "apim_app_forwarder_subscription_key" {
  count = var.app_forwarder_enabled ? 1 : 0

  depends_on   = [azurerm_api_management_subscription.apim_app_forwarder_subkey]
  name         = format("smo-%s-appforwarder-subscription-key", var.env_short)
  value        = azurerm_api_management_subscription.apim_app_forwarder_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}


