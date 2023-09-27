resource "azurerm_data_factory_pipeline" "pipeline_KPI_TPNP" {

  name            = "SMO_KPI_TPNP_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TPNP.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TPNP_DataSet"
  })}]"


  # lifecycle {
  #   ignore_changes = [
  #     activities_json,
  #   ]
  # }
}
