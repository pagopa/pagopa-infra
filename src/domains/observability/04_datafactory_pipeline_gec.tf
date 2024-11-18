########################### PDND CDC GEC BUNDLES PIPELINE ###########################

resource "azurerm_data_factory_pipeline" "pipeline_PDND_CDC_GEC_BUNDLES" {

  name            = "PDND_CDC_GEC_BUNDLES_Pipeline"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  variables = {
  }

  activities_json = "[${templatefile("./datafactory/pipelines/PDND_CDC_GEC_BUNDLES.json", {
    inputdataset = "PDND_CDC_GEC_BUNDLES_JSON_Dataset"
    evh_base_url = "https://pagopa-${var.env_short}-itn-observ-evh.servicebus.windows.net"
  })}]"

  depends_on = [
    azurerm_data_factory_dataset_json.afm_gec_bundle_cdc_json,
    azapi_resource.pdnd_cdc_gec_bundles_dataflow
  ]

  folder = "PDND_CDC_GEC_PIPELINE"
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_PDND_CDC_GEC_BUNDLES" {

  name            = "Trigger_PDND_CDC_GEC_BUNDLES"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  interval  = 3
  frequency = "Hour"
  activated = true
  time_zone = "W. Europe Standard Time"

  description   = "Trigger for PDND_CDC_GEC_BUNDLES_Pipeline"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_BUNDLES.name
}

########################### PDND CDC GEC CIBUNDLES PIPELINE ###########################
resource "azurerm_data_factory_pipeline" "pipeline_PDND_CDC_GEC_CIBUNDLES" {

  name            = "PDND_CDC_GEC_CIBUNDLES_Pipeline"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  variables = {
  }

  activities_json = "[${templatefile("./datafactory/pipelines/PDND_CDC_GEC_CIBUNDLES.json", {
    inputdataset = "PDND_CDC_GEC_CIBUNDLES_JSON_Dataset"
    evh_base_url = "https://pagopa-${var.env_short}-itn-observ-evh.servicebus.windows.net"
  })}]"

  depends_on = [
    azurerm_data_factory_dataset_json.afm_gec_cibundle_cdc_json,
    azapi_resource.pdnd_cdc_gec_cibundles_dataflow
  ]

  folder = "PDND_CDC_GEC_PIPELINE"
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_PDND_CDC_GEC_CIBUNDLES" {

  name            = "Trigger_PDND_CDC_GEC_CIBUNDLES"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  interval  = 3
  frequency = "Hour"
  activated = true
  time_zone = "W. Europe Standard Time"

  description   = "Trigger for PDND_CDC_GEC_CIBUNDLES_Pipeline"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_CIBUNDLES.name
}

########################### PDND CDC GEC PAYMENTTYPES PIPELINE ###########################
resource "azurerm_data_factory_pipeline" "pipeline_PDND_CDC_GEC_PAYMENTTYPES" {

  name            = "PDND_CDC_GEC_PAYMENTTYPES_Pipeline"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  variables = {
  }

  activities_json = "[${templatefile("./datafactory/pipelines/PDND_CDC_GEC_PAYMENTTYPES.json", {
    inputdataset = "PDND_CDC_GEC_PAYMENTTYPES_JSON_Dataset"
    evh_base_url = "https://pagopa-${var.env_short}-itn-observ-evh.servicebus.windows.net"
  })}]"

  depends_on = [
    azurerm_data_factory_dataset_json.afm_gec_paymenttypes_cdc_json,
    azapi_resource.pdnd_cdc_gec_paymenttypes_dataflow
  ]

  folder = "PDND_CDC_GEC_PIPELINE"
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_PDND_CDC_GEC_PAYMENTTYPES" {

  name            = "Trigger_PDND_CDC_GEC_PAYMENTTYPES"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  interval  = 3
  frequency = "Hour"
  activated = true
  time_zone = "W. Europe Standard Time"

  description   = "Trigger for PDND_CDC_GEC_PAYMENTTYPES_Pipeline"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_PAYMENTTYPES.name
}

########################### PDND CDC GEC TOUCHPOINTS PIPELINE ###########################
resource "azurerm_data_factory_pipeline" "pipeline_PDND_CDC_GEC_TOUCHPOINTS" {

  name            = "PDND_CDC_GEC_TOUCHPOINTS_Pipeline"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  variables = {
  }

  activities_json = "[${templatefile("./datafactory/pipelines/PDND_CDC_GEC_TOUCHPOINTS.json", {
    inputdataset = "PDND_CDC_GEC_TOUCHPOINTS_JSON_Dataset"
    evh_base_url = "https://pagopa-${var.env_short}-itn-observ-evh.servicebus.windows.net"
  })}]"

  depends_on = [
    azurerm_data_factory_dataset_json.afm_gec_paymenttypes_cdc_json,
    azapi_resource.pdnd_cdc_gec_paymenttypes_dataflow
  ]

  folder = "PDND_CDC_GEC_PIPELINE"
}

resource "azurerm_data_factory_trigger_schedule" "Trigger_PDND_CDC_GEC_TOUCHPOINTS" {

  name            = "Trigger_PDND_CDC_GEC_TOUCHPOINTS"
  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id

  interval  = 3
  frequency = "Hour"
  activated = true
  time_zone = "W. Europe Standard Time"

  description   = "Trigger for PDND_CDC_GEC_TOUCHPOINTS_Pipeline"
  pipeline_name = azurerm_data_factory_pipeline.pipeline_PDND_CDC_GEC_TOUCHPOINTS.name
}