
data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}

data "azurerm_key_vault_secret" "github_pat" {
  name         = "payments-cloud-github-bot-pat"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "cloudo_slack_token" {
  name         = "cloudo-slack-token"
  key_vault_id = data.azurerm_key_vault.key_vault.id

}

data "azurerm_key_vault_secret" "opsgenie_token" {
  count        = var.env_short == "p" ? 1 : 0
  name         = "opsgenie-webhook-token"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}


data "azurerm_application_insights" "app_insight" {
  name                = var.application_insisght_name
  resource_group_name = var.application_insisght_resource_group_name
}


data "azurerm_kubernetes_cluster" "aks_weu" {
  name                = "${local.product_region}-${var.env}-aks"
  resource_group_name = "${local.product_region}-${var.env}-aks-rg"
}

data "azurerm_kubernetes_cluster" "aks_itn" {
  name                = "${local.product_ita}-${var.env}-aks"
  resource_group_name = "${local.product_ita}-${var.env}-aks-rg"
}
