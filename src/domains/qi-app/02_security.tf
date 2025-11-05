data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}


// apikey for Jira Service Now
# https://pagopa.atlassian.net/wiki/spaces/PPAOP/pages/1392934964/Design+Integrazione#Infrastruttura-To-Be-senza-Forwarder
resource "azurerm_api_management_subscription" "jira_service_now_subkey" {
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = module.apim_qi_smo_jira_tickets_product.id
  display_name  = "JIRA ServiceNow ApiKey For pagoPA QI SMO JIRA TICKETS pagoPA"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "jira_service_now_subkey_kv" {

  depends_on   = [azurerm_api_management_subscription.jira_service_now_subkey]
  name         = "api-key-jira-service-now"
  value        = azurerm_api_management_subscription.jira_service_now_subkey.primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
