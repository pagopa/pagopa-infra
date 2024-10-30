###################### PDND_CDC_GEC_BUNBLES_DataFlow #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_bundles_dataflow" {
  depends_on = [
    azurerm_data_factory_linked_service_cosmosdb.afm_gec_cosmosdb_linked_service,
    azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
  ]

  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_BUNBLES_DataFlow"

  source {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
    }

    name        = "cosmos_ls_bundles"
    description = "Import data from Analytical Store"
  }

  transformation {
    name        = "transformDateFormat"
    description = "Transform date format from array to string"
  }

  transformation {
    name        = "selectFields"
    description = "Select the Date fields with the right format"
  }

  sink {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
    }
    name        = "afmgecstorage"
    description = "Write data to blob storage in json format"
  }

  script = templatefile("./datafactory/dataflows/PDND_CDC_GEC_BUNDLES.dsl", { # src/domains/observability/datafactory/dataflows/PDND_CDC_GEC_BUNDLES.dsl
    container_name = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
  })

  folder = "PDND_CDC_GEC_DATAFLOW"
}

###################### PDND_CDC_GEC_CIBUNBLES #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_cibundles_dataflow" {
  depends_on = [
    azurerm_data_factory_linked_service_cosmosdb.afm_gec_cosmosdb_linked_service,
    azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
  ]

  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_CIBUNBLES_DataFlow"

  source {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
    }

    name        = "cosmos_ls_cibundles"
    description = "Import data from Analytical Store"
  }

  transformation {
    name        = "formatDate"
    description = "Format Date string"
  }

  transformation {
    name        = "selctOutputFields"
    description = "select and rename fields"
  }

  transformation {
    name        = "flattenAttribute"
    description = "flattern column:\n - id\n - maxPaymentAmount\n - transferCategory\n - transferCategoryRelation\n- insertedDate"
  }

  transformation {
    name        = "aggregateAttribute"
    description = "Add attribute columns:\n - id\n - maxPaymentAmount\n - transferCategory\n - transferCategoryRelation\n- insertedDate"
  }

  sink {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
    }
    name        = "afmgecstorage"
    description = "Write data to blob storage in json format"
  }

  script = templatefile("./datafactory/dataflows/PDND_CDC_GEC_CIBUNDLES.dsl", {
    container_name = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
  })

  folder = "PDND_CDC_GEC_DATAFLOW"
}

###################### PDND_CDC_GEC_TOUCHPOINTS_DataFlow #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_touchpoints_dataflow" {
  depends_on = [
    azurerm_data_factory_linked_service_cosmosdb.afm_gec_cosmosdb_linked_service,
    azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
  ]

  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_BUNBLES_DataFlow"

  source {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
    }

    name        = "cosmos_ls_touchpoints"
    description = "Import data from Analytical Store"
  }

  transformation {
    name        = "formatDateString"
    description = "Transform date format from array to string"
  }

  transformation {
    name        = "selectOutputFileds"
    description = "Select the Date fields with the right format"
  }

  sink {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
    }
    name        = "afmgecstorage"
    description = "Write data to blob storage in json format"
  }

  script = templatefile("./datafactory/dataflows/PDND_CDC_GEC_TOUCHPOINTS.dsl", {
    container_name = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
  })

  folder = "PDND_CDC_GEC_DATAFLOW"
}


###################### PDND_CDC_GEC_PAYMENTTYPES_DataFlow #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_paymenttypes_dataflow" {
  depends_on = [
    azurerm_data_factory_linked_service_cosmosdb.afm_gec_cosmosdb_linked_service,
    azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
  ]

  data_factory_id = data.azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_BUNBLES_DataFlow"

  source {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
    }

    name        = "cosmos_ls_paymenttypes"
    description = "Import data from Analytical Store"
  }

  transformation {
    name        = "formatDateString"
    description = "Transform date format from array to string"
  }

  transformation {
    name        = "selectOutputFileds"
    description = "Select the Date fields with the right format"
  }

  sink {
    linked_service {
      name = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
    }
    name        = "afmgecstorage"
    description = "Write data to blob storage in json format"
  }

  script = templatefile("./datafactory/dataflows/PDND_CDC_GEC_PAYMENTTYPES.dsl", {
    container_name = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
  })

  folder = "PDND_CDC_GEC_DATAFLOW"
}
