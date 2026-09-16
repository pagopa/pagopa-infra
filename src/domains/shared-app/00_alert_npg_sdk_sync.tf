# NPG SDK sync staleness alert
#
# The NPG SDK is self-hosted on the platform CDN and republished by the cdn-assets 
# NPG SDK sync pipeline (https://github.com/pagopa/pagopa-platform-cdn-assets), 
# which runs every 3 hours and emits a `NpgSdkSyncSuccess` customEvent to App Insights.
# Three frontends (checkout-fe, wallet-fe, ecommerce-fe) consume the same CDN folders in the same way.
#
# No `NpgSdkSyncSuccess` heartbeat in the last 7h means the sync has stopped or is failing, 
# so the served SDK/hash may be stale. The 7h window is sized to the every-3-hours cadence: 
# one missed or late run does not page, ~2 consecutive misses do.
#
# On trigger: check the cdn-assets sync pipeline and all three products (checkout, pay-wallet, ecommerce).
#
# Responder: the checkout OpsGenie action group (data source declared in 00_monitor.tf alongside the others)
resource "azurerm_monitor_scheduled_query_rules_alert" "npg_sdk_sync_staleness" {
  count = var.env_short == "p" ? 1 : 0

  name                = "${local.project}-npg-sdk-sync-staleness-alert"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  location            = var.location

  action {
    #action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.checkout_opsgenie[0].id, data.azurerm_monitor_action_group.ecommerce_opsgenie[0].id, data.azurerm_monitor_action_group.pay_wallet_opsgenie[0].id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Platform] NPG SDK sync stale - no successful sync in the last 7h"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "No NpgSdkSyncSuccess heartbeat in the last 7 hours: the NPG SDK sync pipeline (runs every 3 hours) may have stopped or be failing, so the served SDK/hash could be stale. Check the cdn-assets sync pipeline and all three payment frontends."
  enabled        = true
  # single fire while the sync is down + auto-resolve once heartbeats resume
  auto_mitigation_enabled = true
  query = (<<-QUERY
customEvents
| where name == "NpgSdkSyncSuccess"
  QUERY
  )

  severity    = 1
  frequency   = 30
  time_window = 420
  trigger {
    operator  = "LessThan"
    threshold = 1
  }
}
