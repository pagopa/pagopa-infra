##############
## Products ##
##############

# Doc sendPaymentResultV2
# https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/654541075/RFC+Gestione+clientId+per+integrazione+Software+Client#Diagramma-dettaglio-flusso

module "apim_receipt_for_ndp_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  count = var.enable_sendPaymentResultV2_SWClient ? 1 : 0

  product_id   = "receipt_for_ndp"
  display_name = "Receipt sendPaymentResult for NDP"
  description  = "Receipt sendPaymentResult for NDP"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 10

  policy_xml = file("./api_product/receipt_for_ndp/_base_policy.xml")
}

locals {
  apim_receipt_for_ndp_service_api = {
    display_name          = "Receipt sendPaymentResult for NDP"
    description           = "Receipt sendPaymentResult for NDP"
    path                  = "receipt-ndp"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_receipt_for_ndp_api" {
  count = var.enable_sendPaymentResultV2_SWClient ? 1 : 0

  name                = format("%s-receipt-npd-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_receipt_for_ndp_service_api.display_name
  versioning_scheme   = "Segment"
}


# get secrets
data "azurerm_key_vault_secret" "client_id_swclient" {
  name         = "clientIdSwClient"
  key_vault_id = data.azurerm_key_vault.kv.id
}
# get secrets
data "azurerm_key_vault_secret" "client_secret_swclient" {
  name         = "clientSecret"
  key_vault_id = data.azurerm_key_vault.kv.id
}
# get secrets
data "azurerm_key_vault_secret" "subscriptionkey_ecomm" {
  name         = "subscriptionKeyEcomm"
  key_vault_id = data.azurerm_key_vault.kv.id
}

module "apim_api_receipt_for_ndp_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  count = var.enable_sendPaymentResultV2_SWClient ? 1 : 0

  name                  = format("%s-receipt-npd-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_receipt_for_ndp_product[0].product_id]
  subscription_required = local.apim_receipt_for_ndp_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_receipt_for_ndp_api[0].id
  api_version           = "v1"

  description  = local.apim_receipt_for_ndp_service_api.description
  display_name = local.apim_receipt_for_ndp_service_api.display_name
  path         = local.apim_receipt_for_ndp_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_receipt_for_ndp_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/receipt_for_ndp/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_receipt_for_ndp_product[0].product_id
  })

  # xml_content = templatefile("./api/receipt_for_ndp/v1/_base_policy.xml", {
  #   hostname = local.nodo_hostname
  # })
  xml_content = templatefile("./api/receipt_for_ndp/v1/_base_policy.xml.tpl", {
    endpoint1           = local.endpoint1
    endpoint2           = local.endpoint2
    authorizationServer = local.authorizationServer
    clientId            = data.azurerm_key_vault_secret.client_id_swclient.value
    clientSecret        = data.azurerm_key_vault_secret.client_secret_swclient.value
    subscriptionKey     = data.azurerm_key_vault_secret.subscriptionkey_ecomm.value
    environ             = var.env
  })
}
