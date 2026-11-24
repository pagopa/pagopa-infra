##############
## Products ##
##############

module "apim_posgw_debtposition_handler_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "posgw-debtposition-handler"
  display_name = "posgw pagoPA debt position handler service"
  description  = "Product for posgw pagoPA debt position handler service"

  api_management_name = local.apim_name
  resource_group_name = local.apim_rg_name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#############################################
## API posgw debt position handler service ##
#############################################
locals {
  apim_posgw_debtposition_handler_api = {
    display_name          = "pagoPA posgw - debt position handler API"
    description           = "API to create and invalidate debt positions for the POS gateway flow"
    path                  = "posgw/debtposition-handler"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "posgw_debtposition_handler_api" {
  name                = "${local.project}-debtposition-handler-api"
  resource_group_name = local.apim_rg_name
  api_management_name = local.apim_name
  display_name        = local.apim_posgw_debtposition_handler_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_posgw_debtposition_handler_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-debtposition-handler-api"
  api_management_name   = local.apim_name
  resource_group_name   = local.apim_rg_name
  product_ids           = [module.apim_posgw_debtposition_handler_product.product_id]
  subscription_required = local.apim_posgw_debtposition_handler_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.posgw_debtposition_handler_api.id
  api_version           = "v1"

  description  = local.apim_posgw_debtposition_handler_api.description
  display_name = local.apim_posgw_debtposition_handler_api.display_name
  path         = local.apim_posgw_debtposition_handler_api.path
  protocols    = ["https"]
  service_url  = local.apim_posgw_debtposition_handler_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/posgw-debtposition-handler/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/posgw-debtposition-handler/v1/_base_policy.xml.tpl", {
    hostname = local.domain_hostname
  })
}

# subscription key for posgw components calling the debt position handler API
resource "azurerm_api_management_subscription" "posgw_debtposition_handler_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_posgw_debtposition_handler_product.id
  display_name        = "Subscription for posgw debt position handler api"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_key_vault_secret" "posgw_debtposition_handler_subscription_key" {
  name         = "debtposition-handler-api-sub-key"
  value        = azurerm_api_management_subscription.posgw_debtposition_handler_subkey.primary_key
  content_type = "text/plain"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}
