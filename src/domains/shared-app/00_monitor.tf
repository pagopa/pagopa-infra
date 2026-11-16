data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}

# Checkout OpsGenie action group (ChkOpsgenie), defined in the checkout-common domain
# Referenced by the NPG SDK sync staleness alert
data "azurerm_monitor_action_group" "checkout_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = local.monitor_action_group_checkout_opsgenie_rg_name
  name                = local.monitor_action_group_checkout_opsgenie_name
}

# eCommerce OpsGenie action group (EcomOpsgenie), defined in the ecommerce-common domain
# Referenced by the NPG SDK sync staleness alert
data "azurerm_monitor_action_group" "ecommerce_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = local.monitor_action_group_ecommerce_opsgenie_rg_name
  name                = local.monitor_action_group_ecommerce_opsgenie_name
}

# Pay Wallet OpsGenie action group (PayWalletOpsgenie), defined in the pay-wallet-common domain
# Referenced by the NPG SDK sync staleness alert
data "azurerm_monitor_action_group" "pay_wallet_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = local.monitor_action_group_pay_wallet_opsgenie_rg_name
  name                = local.monitor_action_group_pay_wallet_opsgenie_name
}
