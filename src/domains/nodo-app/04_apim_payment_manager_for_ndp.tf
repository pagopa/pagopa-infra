##############
## Products ##
##############

# Doc sendPaymentResultV2
# https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/654541075/RFC+Gestione+clientId+per+integrazione+Software+Client#Diagramma-dettaglio-flusso

######################
## API PM per Nodo  ##
## Ecomm & SwClient ##
######################

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

locals {
  apim_pm_per_nodo_v2 = {
    display_name                 = "Payment Manager - PM per Nodo API (Ecomm & SwClient)"
    description                  = "PM Apis per Nodo"
    path                         = "payment-manager/pm-per-nodo"
    apim_payment_manager_product = "payment-manager"
    apim_x_node_product_id       = "apim_for_node"
    subscription_required        = true
    pm_per_nodo_api              = "${local.project_short}-pm-per-nodo-api"
    service_url                  = null
  }
}

data "azurerm_api_management_api_version_set" "pm_events_api" {
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  name                = local.apim_pm_per_nodo_v2.pm_per_nodo_api
}


module "apim_pm_per_nodo_v2" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"


  name                  = "${local.project_short}-pm-per-nodo-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [local.apim_pm_per_nodo_v2.apim_payment_manager_product, local.apim_pm_per_nodo_v2.apim_x_node_product_id]
  subscription_required = local.apim_pm_per_nodo_v2.subscription_required
  version_set_id        = data.azurerm_api_management_api_version_set.pm_events_api.id
  api_version           = "v2"

  description  = local.apim_pm_per_nodo_v2.description
  display_name = local.apim_pm_per_nodo_v2.display_name
  path         = local.apim_pm_per_nodo_v2.path
  protocols    = ["https"]

  service_url = local.apim_pm_per_nodo_v2.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/pm-per-nodo/v2/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = local.apim_pm_per_nodo_v2.apim_payment_manager_product
  })

  # xml_content = templatefile("./api/receipt_for_ndp/v1/_base_policy.xml", {
  #   hostname = local.nodo_hostname
  # })
  xml_content = templatefile("./api/payment_manager_api/pm-per-nodo/v2/_base_policy.xml.tpl", {
    endpoint1           = local.endpoint1
    endpoint2           = local.endpoint2
    authorizationServer = local.authorizationServer
    clientId            = data.azurerm_key_vault_secret.client_id_swclient.value
    clientSecret        = data.azurerm_key_vault_secret.client_secret_swclient.value
    subscriptionKey     = data.azurerm_key_vault_secret.subscriptionkey_ecomm.value
    environ             = var.env
  })
}
