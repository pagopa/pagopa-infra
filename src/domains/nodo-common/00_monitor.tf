data "azurerm_key_vault_secret" "pgres_flex_admin_pwd" {
  name         = "nodo-sms-list"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}


data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
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

resource "azurerm_monitor_action_group" "sms" {
  name                = "SMSNodoPagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "SMSNodo"


  dynamic "sms_receiver" {
    for_each = toset(data.azurerm_key_vault_secret.pgres_flex_admin_pwd)
      content {
        name         = format("nodosms-%s", each.key)
        country_code = "39"
        phone_number = each.key
      }
  }
 
}