# pagopa-pagamenti-alert
resource "azurerm_monitor_action_group" "slack_channel_pagopa_pagamenti_alert" {
  name                = "PagamentiAlert"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "PgmntAlert"

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.slack_pagopa_pagamenti_alert_email.value
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}
