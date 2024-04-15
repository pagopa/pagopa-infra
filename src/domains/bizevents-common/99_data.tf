data "azurerm_data_factory" "data_factory" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

data "azurerm_key_vault_secret" "tokenizer_api_key" {
  name         = "tokenizer-api-key"
  key_vault_id = module.key_vault.id
}
