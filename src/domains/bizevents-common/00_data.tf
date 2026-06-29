data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}

data "azurerm_key_vault" "nodo_key_vault" {
  name                = "${local.product}-nodo-kv"
  resource_group_name = "${local.product}-nodo-sec-rg"
}

data "azurerm_key_vault_secret" "db_nexi_biz_pagopa_sv_password" {
  count        = var.env_short != "d" ? 1 : 0
  name         = "db-nexi-biz-pagopa-sv-password"
  key_vault_id = data.azurerm_key_vault.nodo_key_vault.id
}

data "azurerm_data_factory" "data_factory" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

data "azurerm_key_vault_secret" "tokenizer_api_key" {
  count        = var.env_short == "d" ? 1 : 0 # used for ADF biz test developer
  name         = "tokenizer-api-key"
  key_vault_id = module.key_vault.id
}

# linked service df vs cosmos
data "azurerm_cosmosdb_account" "bizevent_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-bizevents-ds-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-bizevents-rg"
}
data "azurerm_cosmosdb_account" "bizevent_cosmos_account_dev" {
  count = var.env_short == "d" ? 1 : 0 # used for ADF biz test developer

  name                = "pagopa-${var.env_short}-${var.location_short}-bizevents-ds-cosmos-account-dev"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-bizevents-rg"
}
