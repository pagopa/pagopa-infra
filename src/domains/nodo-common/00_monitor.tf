data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

/* data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
} */


data "azurerm_key_vault_secret" "slackemail" {
  name         = "nodo-slack-channel"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_key_vault_secret" "techemail" {
  name         = "nodo-tech-support"
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

resource "azurerm_monitor_action_group" "slack" {
  name                = "SlackPagoPANODO"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "SlackNodo"


  email_receiver {
    name          = "sendtoadminnodo"
    email_address = data.azurerm_key_vault_secret.slackemail.value
  }

}

resource "azurerm_monitor_action_group" "push" {
  name                = "PushNodoPagoPA"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "PushNodo"


  dynamic "azure_app_push_receiver" {

    for_each = data.azurerm_key_vault_secret.tech_support.value
    content {
      name          = format("nodo-push-%s", replace(azure_app_push_receiver.value, "@", "_"))
      email_address = azure_app_push_receiver.value
    }
  }

}
