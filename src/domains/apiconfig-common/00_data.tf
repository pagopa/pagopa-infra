data "azurerm_key_vault" "nodo_key_vault" {
  name                = "pagopa-${var.env_short}-nodo-kv"
  resource_group_name = "pagopa-${var.env_short}-nodo-sec-rg"
}

data "azurerm_key_vault_secret" "key_vault_db_postgres_nexi_cfg_password" {
  name         = "db-nexi-cfg-password"
  key_vault_id = data.azurerm_key_vault.nodo_key_vault.id
}
