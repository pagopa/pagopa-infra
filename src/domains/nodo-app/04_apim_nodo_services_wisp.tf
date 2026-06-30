
# nodoInviaRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaRPT_api_v1_policy_ndp" {
  count = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = var.env_short == "d" ? "63bff3b0c257811280ef760a" : var.env_short == "u" ? "63d1612239519a10d0113a06" : "63d93febf6c0271814e8909e"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaRPT_policy.xml")
}

# nodoInviaCarrelloRPT
resource "azurerm_api_management_api_operation_policy" "nodoInviaCarrelloRPT_api_v1_policy_ndp" {
  count = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_ndp.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = var.env_short == "d" ? "63bff3b0c257811280ef760b" : var.env_short == "u" ? "63d1612239519a10d0113a07" : "63d93febf6c0271814e8909f"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaCarrelloRPT_policy.xml")
}
