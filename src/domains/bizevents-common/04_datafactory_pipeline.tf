resource "azurerm_data_factory_pipeline" "pipeline_biz_to_view" {
  depends_on = [azurerm_data_factory_data_flow.write_biz_events_to_biz_view]

  name            = "BIZEVENTS_TO_BIZVIEW_Pipeline"
  data_factory_id = data.azurerm_data_factory.data_factory.id

  parameters = {
    daysToRecover = 7
  }

  activities_json = "[${templatefile("datafactory/pipelines/BIZEVENTS_TO_BIZVIEW_Pipeline.json", {
    dataflow_biz = "writeBizEventsToBizView"
  })}]"

}
