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