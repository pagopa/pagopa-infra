data "azurerm_subnet" "apim_snet" {
  name                 = local.apim_subnet_name
  virtual_network_name = local.vnet_integration_name
  resource_group_name  = local.vnet_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = var.monitor_resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = "${local.product}-kv"
  resource_group_name = "${local.product}-sec-rg"
}

data "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_ha_enabled ? "${var.prefix}-${var.env_short}-${var.location_short}-redis" : "${var.prefix}-${var.env_short}-redis"
  resource_group_name = "${var.prefix}-${var.env_short}-data-rg"
}

data "azuread_service_principal" "iac_principal" {
  count        = var.enable_iac_pipeline ? 1 : 0
  display_name = "pagopaspa-pagoPA-iac-${data.azurerm_subscription.current.subscription_id}"
}

data "azurerm_key_vault" "shared_kv" {
  name                = "${local.product}-shared-kv"
  resource_group_name = "${local.product}-shared-sec-rg"
}

data "azurerm_key_vault_secret" "pagopa_platform_shared_github_bot_cd_pat" {
  name         = "pagopa-platform-domain-github-bot-cd-pat"
  key_vault_id = data.azurerm_key_vault.shared_kv.id
}

data "azurerm_key_vault_secret" "pagopa_pagamenti_integration_test_slack_webhook" {
  name         = "pagopa-pagamenti-integration-test-slack-webhook"
  key_vault_id = data.azurerm_key_vault.shared_kv.id
}

data "azurerm_key_vault_secret" "pagopa_pagamenti_deploy_slack_webhook" {
  name         = "pagopa-pagamenti-deploy-slack-webhook"
  key_vault_id = data.azurerm_key_vault.shared_kv.id
}
