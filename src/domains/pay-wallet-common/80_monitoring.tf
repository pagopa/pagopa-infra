# module "web_test_availability_alert_rules_for_api" {
#   for_each = { for v in local.test_urls : v.host => v if v != null }
#   source   = "git::https://github.com/pagopa/terraform-azurerm-v3.git//application_insights_web_test_preview?ref=v8.20.1"
#
#   subscription_id                   = data.azurerm_subscription.current.subscription_id
#   name                              = "test-avail-${each.value.host}"
#   location                          = data.azurerm_resource_group.monitor_italy_rg.location
#   resource_group                    = data.azurerm_resource_group.monitor_italy_rg.name
#   application_insight_name          = data.azurerm_application_insights.application_insights_italy.name
#   application_insight_id            = data.azurerm_application_insights.application_insights_italy.id
#   request_url                       = "https://${each.value.host}${each.value.path}"
#   ssl_cert_remaining_lifetime_check = 7
#   expected_http_status              = each.value.expected_http_status
#
#   actions = [
#     {
#       action_group_id = data.azurerm_monitor_action_group.email.id,
#     },
#     {
#       action_group_id = data.azurerm_monitor_action_group.slack.id,
#     },
#   ]
# }
