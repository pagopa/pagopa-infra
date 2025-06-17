data "azurerm_key_vault" "kv" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}




// apikey test for AFM Calculator
resource "azurerm_api_management_subscription" "test_afm_calculator_subkey" {
  count               = var.env_short != "p" ? 1 : 0
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id    = module.apim_afm_calculator_product.id
  display_name  = "Integ-test apim_afm_calculator_product"
  allow_tracing = false
  state         = "active"
}

resource "azurerm_key_vault_secret" "test_afm_calculator_subkey_kv" {
  count        = var.env_short != "p" ? 1 : 0
  depends_on   = [azurerm_api_management_subscription.test_afm_calculator_subkey[0]]
  name         = "integration-test-afm-calculator-subkey"
  value        = azurerm_api_management_subscription.test_afm_calculator_subkey[0].primary_key
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv.id
}
