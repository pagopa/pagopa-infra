locals {
  # if severity > 0
  action_groups_slack_pagopa_pagamenti_alert = [
    data.azurerm_monitor_action_group.slack_pagopa_pagamenti_alert.id
  ]

  # if environment is UAT
  action_groups_email = [data.azurerm_monitor_action_group.email.id]

  # Enabled alert on production after deploy, if severity == 0
  action_groups_opsgenie = var.env_short == "p" ? concat([
    data.azurerm_monitor_action_group.opsgenie[0].id
  ], local.action_groups_email) : local.action_groups_email
}
