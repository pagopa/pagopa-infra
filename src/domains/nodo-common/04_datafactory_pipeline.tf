locals {
  time_zone = "W. Europe Standard Time"
}

resource "azurerm_data_factory_pipeline" "pipeline_re" {
  depends_on      = [azurerm_data_factory_data_flow.dataflow_re]
  name            = "cleanRePipeline"
  data_factory_id = azurerm_data_factory.data_factory.id

  parameters = {
    daysToKeep = 90
  }

  activities_json = file("datafactory/pipelines/reActivities.json")
}

resource "azurerm_data_factory_pipeline" "pipeline_wfesp" {
  depends_on      = [azurerm_data_factory_data_flow.dataflow_wfesp]
  name            = "cleanWfespPipeline"
  data_factory_id = azurerm_data_factory.data_factory.id

  parameters = {
    daysToKeep = 90
  }

  activities_json = file("datafactory/pipelines/wfespActivities.json")

  lifecycle { create_before_destroy = true }
}

resource "azurerm_data_factory_pipeline" "pipeline_online" {
  depends_on      = [azurerm_data_factory_data_flow.dataflow_online]
  name            = "cleanOnlinePipeline"
  data_factory_id = azurerm_data_factory.data_factory.id

  parameters = {
    daysToKeep = 90
  }

  activities_json = file("datafactory/pipelines/onlineActivities.json")
}
