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

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]

}
resource "azurerm_data_factory_pipeline" "pipeline_KPI_TPNP_Recupero" {

  name            = "SMO_KPI_TPNP_Recupero_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  parameters = {
    run_id     = "09753e8b-7920-453a-b54c-512ec3e39756"
    start_date = ""
  }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TPNP_Recupero.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TPNP_DataSet"
  })}]"

}
