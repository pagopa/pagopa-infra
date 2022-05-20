# resource "azurerm_resource_group" "pagopa_logic_app" {
#   name     = format("%s-logic-app-rg", local.project)
#   location = var.location

#   tags = var.tags
# }

# resource "azurerm_logic_app_workflow" "logic_app_biz_events" {
#   name                = format("%s-logic-app-wf-biz-event", local.project)
#   resource_group_name = azurerm_resource_group.pagopa_logic_app.name
#   location            = azurerm_resource_group.pagopa_logic_app.location
# }

# resource "azurerm_logic_app_trigger_custom" "logic_app_biz_events_trigger" {
#   name         = "example-trigger"
#   logic_app_id = azurerm_logic_app_workflow.example.id

#   body = <<BODY
# {
#   "recurrence": {
#     "frequency": "Day",
#     "interval": 1
#   },
#   "type": "Recurrence"
# }
# BODY

# }
