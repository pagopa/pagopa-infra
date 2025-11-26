# locals {
#   time_zone = "W. Europe Standard Time"
# }

# resource "azurerm_data_factory_trigger_schedule" "trigger_re" {
#   count = var.env_short == "p" ? 0 : 1

#   depends_on      = [azurerm_data_factory_data_flow.dataflow_re]
#   name            = "trigger_re_clean_up"
#   data_factory_id = azurerm_data_factory.data_factory.id

#   interval  = 1
#   frequency = "Day"
#   time_zone = local.time_zone
#   activated = true

#   pipeline_name = azurerm_data_factory_pipeline.pipeline_re[0].name
#   pipeline_parameters = {
#     daysToKeep = 90
#   }

#   schedule {
#     hours   = [0]
#     minutes = [1]
#   }
# }

# resource "azurerm_data_factory_trigger_schedule" "trigger_wfesp" {
#   count = var.env_short == "p" ? 0 : 1

#   depends_on      = [azurerm_data_factory_data_flow.dataflow_wfesp]
#   name            = "trigger_wfesp_clean_up"
#   data_factory_id = azurerm_data_factory.data_factory.id

#   interval  = 1
#   frequency = "Day"
#   time_zone = local.time_zone
#   activated = true

#   pipeline_name = azurerm_data_factory_pipeline.pipeline_wfesp[0].name
#   pipeline_parameters = {
#     daysToKeep = 90
#   }

#   schedule {
#     hours   = [0]
#     minutes = [1]
#   }
# }

# resource "azurerm_data_factory_trigger_schedule" "trigger_online" {
#   count = var.env_short == "p" ? 0 : 1

#   depends_on      = [azurerm_data_factory_data_flow.dataflow_online]
#   name            = "trigger_online_clean_up"
#   data_factory_id = azurerm_data_factory.data_factory.id

#   interval  = 1
#   frequency = "Day"
#   time_zone = local.time_zone
#   activated = true

#   pipeline_name = azurerm_data_factory_pipeline.pipeline_online[0].name
#   pipeline_parameters = {
#     daysToKeep = 90
#   }

#   schedule {
#     hours   = [0]
#     minutes = [1]
#   }
# }
