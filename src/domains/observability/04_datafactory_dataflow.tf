###################### PDND_CDC_GEC_BUNBLES.dataflow #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_bundles.dataflow" {
  depends_on      = [
                        azurerm_data_factory_linked_service_cosmosdb.datasetsafm_gec_u_cdc_linked_service,
                        azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
                    ]

  data_factory_id = azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_BUNBLES.dataflow"

    source {
        linked_service {
            name = afm_gec_cosmosdb_linked_service
        }

        name =  cosmos
        description = "Import data from Analytical Store"
    }

    transformation {
        name = "transformDateFormat"
        description = "Transform date format from array to string"
    }

    transformation {
        name = "selectFields"
        description = "Select the Date fields with the right format"
    }

    sink {
        linked_service {
            name = afm_gec_storage_linked_service
        }
        name = "afmgecstorage"
        description = "Write data to blob storage in json format"
    }

    script = templatefile("datafactory/dataflows/PDND_CDC_GEC_BUNDLES.dsl", {})

    folder = "PDND_CDC_GEC_DATAFLOW"
}

###################### PDND_CDC_GEC_CIBUNBLES.dataflow #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_cibundles.dataflow" {
  depends_on      = [
                        azurerm_data_factory_linked_service_cosmosdb.datasetsafm_gec_u_cdc_linked_service,
                        azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
                    ]

  data_factory_id = azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_CIBUNBLES.dataflow"

    source {
        linked_service {
            name = afm_gec_cosmosdb_linked_service
        }

        name =  cosmos
        description = "Import data from Analytical Store"
    }

    transformation {
        name = "formatDate"
        description = "Format Date string"
    }

    transformation {
        name = "selctOutputFields"
        description = "select and rename fields"
    }

    transformation {
        name = "flattenAttribute"
        description = "flattern column:\n - id\n - maxPaymentAmount\n - transferCategory\n - transferCategoryRelation\n- insertedDate"
    }

    transformation {
        name = "aggregateAttribute"
        description = "Add attribute columns:\n - id\n - maxPaymentAmount\n - transferCategory\n - transferCategoryRelation\n- insertedDate"
    }

    sink {
        linked_service {
            name = afm_gec_storage_linked_service
        }
        name = "afmgecstorage"
        description = "Write data to blob storage in json format"
    }

    script = templatefile("datafactory/dataflows/PDND_CDC_GEC_CIBUNDLES.dsl", {})

    folder = "PDND_CDC_GEC_DATAFLOW"
}

###################### PDND_CDC_GEC_TOUCHPOINTS.dataflow #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_touchpoints.dataflow" {
  depends_on      = [
                        azurerm_data_factory_linked_service_cosmosdb.datasetsafm_gec_u_cdc_linked_service,
                        azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
                    ]

  data_factory_id = azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_BUNBLES.dataflow"

    source {
        linked_service {
            name = afm_gec_cosmosdb_linked_service
        }

        name =  cosmos
        description = "Import data from Analytical Store"
    }

    transformation {
        name = "formatDateString"
        description = "Transform date format from array to string"
    }

    transformation {
        name = "selectOutputFileds"
        description = "Select the Date fields with the right format"
    }

    sink {
        linked_service {
            name = afm_gec_storage_linked_service
        }
        name = "afmgecstorage"
        description = "Write data to blob storage in json format"
    }

    script = templatefile("datafactory/dataflows/PDND_CDC_GEC_TOUCHPOINTS.dsl", {})

    folder = "PDND_CDC_GEC_DATAFLOW"
}


###################### PDND_CDC_GEC_PAYMENTTYPES.dataflow #############################
resource "azurerm_data_factory_data_flow" "pdnd_cdc_gec_paymenttypes.dataflow" {
  depends_on      = [
                        azurerm_data_factory_linked_service_cosmosdb.datasetsafm_gec_u_cdc_linked_service,
                        azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service
                    ]

  data_factory_id = azurerm_data_factory.obeserv_data_factory.id
  name            = "PDND_CDC_GEC_BUNBLES.dataflow"

    source {
        linked_service {
            name = afm_gec_cosmosdb_linked_service
        }

        name =  cosmos
        description = "Import data from Analytical Store"
    }

    transformation {
        name = "formatDateString"
        description = "Transform date format from array to string"
    }

    transformation {
        name = "selectOutputFileds"
        description = "Select the Date fields with the right format"
    }

    sink {
        linked_service {
            name = afm_gec_storage_linked_service
        }
        name = "afmgecstorage"
        description = "Write data to blob storage in json format"
    }

    script = templatefile("datafactory/dataflows/PDND_CDC_GEC_PAYMENTTYPES.dsl", {})

    folder = "PDND_CDC_GEC_DATAFLOW"
}
