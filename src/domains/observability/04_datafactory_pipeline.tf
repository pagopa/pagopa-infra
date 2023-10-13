########################### KPI TPNP ###########################
resource "azurerm_data_factory_pipeline" "pipeline_KPI_TPNP" {

  name            = "SMO_KPI_TPNP_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  variables = {
    run_id = "",
    start_date = "",
    count_record = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TPNP.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TPNP_DataSet"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_TPNP" {

  name            = "Trigger_KPI_TPNP"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 10
  frequency = "Minute"
  activated = true
  time_zone = "W. Europe Standard Time"

  description = "Description of Trigger_KPI_TPNP"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_TPNP.name

}



########################### KPI TPNP RECUPERO ###########################


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






########################### KPI TNSPO ###########################


resource "azurerm_data_factory_pipeline" "pipeline_KPI_TNSPO" {

  name            = "SMO_KPI_TNSPO_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  variables = {
    run_id = "",
    start_date = "",
    count_record = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TNSPO.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TNSPO_Dataset"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_TNSPO" {

  name            = "Trigger_KPI_TNSPO"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 15
  frequency = "Minute"
  activated = true
  time_zone = "W. Europe Standard Time"

  description = "Description of Trigger_KPI_TNSPO"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_TNSPO.name

}


########################### KPI TNSPO_DASPO ###########################


resource "azurerm_data_factory_pipeline" "pipeline_KPI_TPSPO_DASPO" {

  name            = "SMO_KPI_KPI_TPSPO_DASPO_Pipeline"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  #   parameters = {
  #     daysToKeep = 90
  #   }

  # activities_json = file("datafactory/pipelines/KPI_TPNP.json")

  variables = {
    run_id = "",
    start_date = "",
    count_record = ""
  }

  activities_json = "[${templatefile("datafactory/pipelines/KPI_TPSPO_DASPO.json", {
    inputdataset  = "SMO_ReEvent_DataSet"
    outputdataset = "SMO_KPI_TPSPO_DASPO_Dataset"
  })}]"

  depends_on = [
    azurerm_data_factory_custom_dataset.qi_datasets
  ]
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_KPI_TPSPO_DASPO" {

  name            = "Trigger_KPI_TPSPO_DASPO"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id

  interval  = 30
  frequency = "Minute"
  activated = true
  time_zone = "W. Europe Standard Time"

  description = "Description of Trigger_KPI_TPSPO_DASPO"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_KPI_TPSPO_DASPO.name

}