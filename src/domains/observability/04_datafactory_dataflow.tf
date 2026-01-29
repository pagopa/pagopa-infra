###################### PDND_CDC_GEC_BUNDLES_DataFlow #############################
resource "azapi_resource" "pdnd_cdc_gec_bundles_dataflow" {
  type = "Microsoft.DataFactory/factories/dataflows@2018-06-01"
  name = "PDND_CDC_GEC_BUNDLES_DataFlow"
  #parent_id = "/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-weu-nodo-df-rg/providers/Microsoft.DataFactory/factories/pagopa-d-weu-nodo-df"
  parent_id = data.azurerm_data_factory.qi_data_factory.id
  #body = jsonencode({
  body = {
    properties = {
      annotations = []
      description = "CDC GEC BUNDLES"
      folder = {
        name = "PDND_CDC_GEC_DATAFLOW"
      }
      type = "MappingDataFlow"
      typeProperties = {
        #script = ""
        scriptLines = [
          "source(output(",
          "          {_rid} as string,",
          "          {_ts} as long,",
          "          id as string,",
          "          idPsp as string,",
          "          idChannel as string,",
          "          idBrokerPsp as string,",
          "          cart as boolean,",
          "          idCdi as string,",
          "          abi as string,",
          "          pspBusinessName as string,",
          "          urlPolicyPsp as integer,",
          "          digitalStamp as boolean,",
          "          digitalStampRestriction as boolean,",
          "          name as string,",
          "          description as string,",
          "          paymentAmount as long,",
          "          minPaymentAmount as long,",
          "          maxPaymentAmount as long,",
          "          paymentType as string,",
          "          touchpoint as string,",
          "          type as string,",
          "          transferCategoryList as string[],",
          "          validityDateFrom as long[],",
          "          validityDateTo as long[],",
          "          insertedDate as long[],",
          "          lastUpdatedDate as long[],",
          "          {_etag} as string",
          "     ),",
          "     allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     inferDriftedColumnTypes: true,",
          "     container: 'bundles',",
          "     storeType: 'olap',",
          "     format: 'document',",
          "     enableChangeFeed: true,",
          "     changeFeedStartFromTheBeginning: true,",
          "     systemColumns: true,",
          "     captureIntermediateUpdate: false,",
          "     captureUserDeletes: true,",
          "     captureTxnTTLDeletes: true,",
          "     store: 'cosmosDB') ~> cosmosbundles",
          "cosmosbundles derive(lastUpdatedDateString = iif(isNull(lastUpdatedDate), '', toString(lastUpdatedDate[1]) + '-' + lpad(toString(lastUpdatedDate[2]), 2, '0') + '-' + lpad(toString(lastUpdatedDate[3]), 2, '0') + 'T' + lpad(toString(lastUpdatedDate[4]), 2, '0') + ':' + lpad(toString(lastUpdatedDate[5]), 2, '0') + ':' + lpad(toString(lastUpdatedDate[6]), 2, '0') + '.' + lpad(toString(lastUpdatedDate[7]), 2, '0')),",
          "          insertedDateString = iif(isNull(insertedDate), '', toString(insertedDate[1]) + '-' + lpad(toString(insertedDate[2]), 2, '0') + '-' + lpad(toString(insertedDate[3]), 2, '0') + 'T' + lpad(toString(insertedDate[4]), 2, '0') + ':' + lpad(toString(insertedDate[5]), 2, '0') + ':' + lpad(toString(insertedDate[6]), 2, '0') + '.' + lpad(toString(insertedDate[7]), 2, '0')),",
          "          validityDateFromString = iif(isNull(validityDateFrom), '', toString(validityDateFrom[1]) + '-' + lpad(toString(validityDateFrom[1]), 2, '0') + '-' + lpad(toString(validityDateFrom[1]), 2, '0')),",
          "          validityDateToString = iif(isNull(validityDateTo), '', toString(validityDateTo[1]) + '-' + lpad(toString(validityDateTo[1]), 2, '0') + '-' + lpad(toString(validityDateTo[1]), 2, '0')),",
          "          {_etag} = regexReplace({_etag}, '\\\"', '')) ~> transformDateFormat",
          "transformDateFormat select(mapColumn(",
          "          {_rid},",
          "          {_ts},",
          "          id,",
          "          idPsp,",
          "          idChannel,",
          "          idBrokerPsp,",
          "          cart,",
          "          idCdi,",
          "          abi,",
          "          pspBusinessName,",
          "          urlPolicyPsp,",
          "          digitalStamp,",
          "          digitalStampRestriction,",
          "          name,",
          "          description,",
          "          paymentAmount,",
          "          minPaymentAmount,",
          "          maxPaymentAmount,",
          "          paymentType,",
          "          touchpoint,",
          "          type,",
          "          transferCategoryList,",
          "          {_etag},",
          "          lastUpdatedDate = lastUpdatedDateString,",
          "          insertedDate = insertedDateString,",
          "          validityDateFrom = validityDateFromString,",
          "          validityDateTo = validityDateToString",
          "     ),",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> selectFields",
          "selectFields sink(allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     format: 'json',",
          "     container: 'pagopa-${var.env_short}-itn-observ-az-blob-observability-container',",
          "     folderPath: 'bundles',",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> afmgecstorage"
        ]
        sinks = [
          {
            description = "Write data to blob storage in json format"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
              type          = "LinkedServiceReference"
            }
            name = "afmgecstorage"
          }
        ]
        sources = [
          {
            description = "Import data from Analytical Store"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
              type          = "LinkedServiceReference"
            }
            name = "cosmosbundles"
          }
        ]
        transformations = [
          {
            name        = "transformDateFormat"
            description = "Transform date format from array to string"
          },
          {
            name        = "selectFields"
            description = "Select the Date fields with the right format"
          }
        ]
      }
    }
    #  })
  }
}

###################### PDND_CDC_GEC_CIBUNDLES #############################
resource "azapi_resource" "pdnd_cdc_gec_cibundles_dataflow" {
  type      = "Microsoft.DataFactory/factories/dataflows@2018-06-01"
  name      = "PDND_CDC_GEC_CIBUNDLES_DataFlow"
  parent_id = data.azurerm_data_factory.qi_data_factory.id
  #body = jsonencode({
  body = {
    properties = {
      annotations = []
      description = "CDC GEC CIBUNDLES"
      folder = {
        name = "PDND_CDC_GEC_DATAFLOW"
      }
      type = "MappingDataFlow"
      typeProperties = {
        #script = ""
        scriptLines = [
          "source(output(",
          "          {_rid} as string,",
          "          {_ts} as long,",
          "          ciFiscalCode as string,",
          "          idBundle as string,",
          "          type as string,",
          "          attributes as (id as string, maxPaymentAmount as long, transferCategory as string, transferCategoryRelation as string, insertedDate as long[])[],",
          "          validityDateFrom as long[],",
          "          validityDateTo as long[],",
          "          insertedDate as long[],",
          "          id as string,",
          "          {_etag} as string",
          "     ),",
          "     allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     inferDriftedColumnTypes: true,",
          "     container: 'cibundles',",
          "     storeType: 'olap',",
          "     format: 'document',",
          "     enableChangeFeed: true,",
          "     changeFeedStartFromTheBeginning: true,",
          "     systemColumns: true,",
          "     captureIntermediateUpdate: false,",
          "     captureUserDeletes: true,",
          "     captureTxnTTLDeletes: true,",
          "     store: 'cosmosDB') ~> cibundles",
          "flattenAttribute derive(validityDateFrom = iif(isNull(validityDateFrom), '', toString(validityDateFrom[1]) + '-' + lpad(toString(validityDateFrom[2]), 2, '0') + '-' + lpad(toString(validityDateFrom[3]), 2, '0')),",
          "          validityDateTo = iif(isNull(validityDateTo), '', toString(validityDateTo[1]) + '-' + lpad(toString(validityDateTo[2]), 2, '0') + '-' + lpad(toString(validityDateTo[3]), 2, '0')),",
          "          insertedDate = iif(isNull(insertedDate), '', toString(insertedDate[1]) + '-' + lpad(toString(insertedDate[2]), 2, '0') + '-' + lpad(toString(insertedDate[3]), 2, '0') + 'T' + lpad(toString(insertedDate[4]), 2, '0') + ':' + lpad(toString(insertedDate[5]), 2, '0') + ':' + lpad(toString(insertedDate[6]), 2, '0') + '.' + toString(insertedDate[7])),",
          "          {_etag} = regexReplace({_etag}, '\\\"', ''),",
          "          attributes = @(id=attributes.id,",
          "          maxPaymentAmount=attributes.maxPaymentAmount,",
          "          transferCategory=attributes.transferCategory,",
          "          transferCategoryRelation=attributes.transferCategoryRelation,",
          "          insertedDate=iif(isNull(attributes.insertedDate), ",
          "                              '', ",
          "                              toString(attributes.insertedDate[1]) + '-' + ",
          "                              lpad(toString(attributes.insertedDate[2]), 2, '0') + '-' + ",
          "                              lpad(toString(attributes.insertedDate[3]), 2, '0') + 'T' + ",
          "                              lpad(toString(attributes.insertedDate[4]), 2, '0') + ':' + ",
          "                              lpad(toString(attributes.insertedDate[5]), 2, '0') + ':' + ",
          "                              lpad(toString(attributes.insertedDate[6]), 2, '0') + '.' + ",
          "                              toString(attributes.insertedDate[7])))) ~> formatDate",
          "aggregateAttribute select(mapColumn(",
          "          {_rid},",
          "          {_ts},",
          "          ciFiscalCode,",
          "          idBundle,",
          "          type,",
          "          attributes,",
          "          validityDateFrom,",
          "          validityDateTo,",
          "          insertedDate,",
          "          id,",
          "          {_etag}",
          "     ),",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> selctOutputFields",
          "cibundles foldDown(unroll(attributes, attributes),",
          "     mapColumn(",
          "          {_rid},",
          "          {_ts},",
          "          ciFiscalCode,",
          "          idBundle,",
          "          type,",
          "          attributes,",
          "          validityDateFrom,",
          "          validityDateTo,",
          "          insertedDate,",
          "          id,",
          "          {_etag}",
          "     ),",
          "     skipDuplicateMapInputs: false,",
          "     skipDuplicateMapOutputs: false) ~> flattenAttribute",
          "formatDate aggregate(groupBy({_rid},",
          "          {_ts},",
          "          ciFiscalCode,",
          "          idBundle,",
          "          type,",
          "          validityDateFrom,",
          "          validityDateTo,",
          "          insertedDate,",
          "          id,",
          "          {_etag}),",
          "     attributes = collect(attributes)) ~> aggregateAttribute",
          "selctOutputFields sink(allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     format: 'json',",
          "     container: 'pagopa-${var.env_short}-itn-observ-az-blob-observability-container',",
          "     folderPath: 'cibundles',",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> afmgecstorage"
        ]
        sinks = [
          {
            description = "Write data to blob storage in json format"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
              type          = "LinkedServiceReference"
            }
            name = "afmgecstorage"
          }
        ]
        sources = [
          {
            description = "Import data from Analytical Store"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
              type          = "LinkedServiceReference"
            }
            name = "cibundles"
          }
        ]
        transformations = [
          {
            name        = "formatDate"
            description = "Format Date string"
          },
          {
            name        = "selctOutputFields"
            description = "select and rename fields"
          },
          {
            name        = "flattenAttribute"
            description = "flattern column:\n - id\n - maxPaymentAmount\n - transferCategory\n - transferCategoryRelation\n- insertedDate"
          },
          {
            name        = "aggregateAttribute"
            description = "Add attribute columns:\n - id\n - maxPaymentAmount\n - transferCategory\n - transferCategoryRelation\n- insertedDate"
          }
        ]
      }
    }
    #  })
  }
}

###################### PDND_CDC_GEC_TOUCHPOINTS_DataFlow #############################
resource "azapi_resource" "pdnd_cdc_gec_touchpoints_dataflow" {
  type      = "Microsoft.DataFactory/factories/dataflows@2018-06-01"
  name      = "PDND_CDC_GEC_TOUCHPOINTS_DataFlow"
  parent_id = data.azurerm_data_factory.qi_data_factory.id
  #body = jsonencode({
  body = {
    properties = {
      annotations = []
      description = "CDC GEC TOUCHPOINTS"
      folder = {
        name = "PDND_CDC_GEC_DATAFLOW"
      }
      type = "MappingDataFlow"
      typeProperties = {
        #script = ""
        scriptLines = [
          "source(output(",
          "          {_rid} as string,",
          "          {_ts} as long,",
          "          name as string,",
          "          id as string,",
          "          {_etag} as string,",
          "          creationDate as long[],",
          "          createdDate as long[]",
          "     ),",
          "     allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     inferDriftedColumnTypes: true,",
          "     container: 'touchpoints',",
          "     storeType: 'olap',",
          "     format: 'document',",
          "     enableChangeFeed: true,",
          "     changeFeedStartFromTheBeginning: true,",
          "     systemColumns: true,",
          "     captureIntermediateUpdate: false,",
          "     captureUserDeletes: true,",
          "     captureTxnTTLDeletes: true,",
          "     store: 'cosmosDB') ~> touchpoints",
          "touchpoints derive(createdDate = iif(isNull(createdDate), '', toString(createdDate[1]) + '-' + lpad(toString(createdDate[2]), 2, '0') + '-' + lpad(toString(createdDate[3]), 2, '0')),",
          "          {_etag} = regexReplace({_etag}, '\\\"', '')) ~> formatDateString",
          "formatDateString select(mapColumn(",
          "          {_rid},",
          "          {_ts},",
          "          name,",
          "          id,",
          "          {_etag},",
          "          createdDate",
          "     ),",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> selectOutputFileds",
          "selectOutputFileds sink(allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     format: 'json',",
          "     container: 'pagopa-${var.env_short}-itn-observ-az-blob-observability-container',",
          "     folderPath: 'touchpoints',",
          "     truncate: true,",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> afmgecstorage"
        ]
        sinks = [
          {
            description = "Write data to blob storage in json format"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
              type          = "LinkedServiceReference"
            }
            name = "afmgecstorage"
          }
        ]
        sources = [
          {
            description = "Import data from Analytical Store"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
              type          = "LinkedServiceReference"
            }
            name = "touchpoints"
          }
        ]
        transformations = [
          {
            name        = "formatDateString"
            description = "Convert the Date format from array to string"
          },
          {
            name        = "selectOutputFileds"
            description = "Select output fields"
          }
        ]
      }
    }
    #  })
  }
}

###################### PDND_CDC_GEC_PAYMENTTYPES_DataFlow #############################
resource "azapi_resource" "pdnd_cdc_gec_paymenttypes_dataflow" {
  type      = "Microsoft.DataFactory/factories/dataflows@2018-06-01"
  name      = "PDND_CDC_GEC_PAYMENTTYPES_DataFlow"
  parent_id = data.azurerm_data_factory.qi_data_factory.id
  #body = jsonencode({
  body = {
    properties = {
      annotations = []
      description = "CDC GEC PAYMENT TYPES"
      folder = {
        name = "PDND_CDC_GEC_DATAFLOW"
      }
      type = "MappingDataFlow"
      typeProperties = {
        #script = ""
        scriptLines = [
          "source(output(",
          "          {_rid} as string,",
          "          {_ts} as long,",
          "          id as string,",
          "          name as string,",
          "          description as string,",
          "          createdDate as long[],",
          "          {_etag} as string",
          "     ),",
          "     allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     inferDriftedColumnTypes: true,",
          "     container: 'paymenttypes',",
          "     storeType: 'olap',",
          "     format: 'document',",
          "     enableChangeFeed: true,",
          "     changeFeedStartFromTheBeginning: true,",
          "     systemColumns: true,",
          "     captureIntermediateUpdate: false,",
          "     captureUserDeletes: true,",
          "     captureTxnTTLDeletes: true,",
          "     store: 'cosmosDB') ~> paymenttypes",
          "paymenttypes derive(createdDate = iif(isNull(createdDate), '', toString(createdDate[1]) + '-' + lpad(toString(createdDate[2]), 2, '0') + '-' + lpad(toString(createdDate[3]), 2, '0')),",
          "          {_etag} = regexReplace({_etag}, '\\\"', '')) ~> formatDateString",
          "formatDateString select(mapColumn(",
          "          {_rid},",
          "          {_ts},",
          "          id,",
          "          name,",
          "          description,",
          "          createdDate,",
          "          {_etag}",
          "     ),",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> selectOutputFileds",
          "selectOutputFileds sink(allowSchemaDrift: true,",
          "     validateSchema: false,",
          "     format: 'json',",
          "     container: 'pagopa-${var.env_short}-itn-observ-az-blob-observability-container',",
          "     folderPath: 'paymenttypes',",
          "     truncate: true,",
          "     skipDuplicateMapInputs: true,",
          "     skipDuplicateMapOutputs: true) ~> afmgecstorage"
        ]
        sinks = [
          {
            description = "Write data to blob storage in json format"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-sa-linkedservice"
              type          = "LinkedServiceReference"
            }
            name = "afmgecstorage"
          }
        ]
        sources = [
          {
            description = "Import data from Analytical Store"
            linkedService = {
              parameters    = {}
              referenceName = "afm-gec-${var.env_short}-${var.location_short}-cosmos-linked-service"
              type          = "LinkedServiceReference"
            }
            name = "paymenttypes"
          }
        ]
        transformations = [
          {
            name        = "formatDateString"
            description = "Convert the Date format from array to string"
          },
          {
            name        = "selectOutputFileds"
            description = "Select output fields"
          }
        ]
      }
    }
    #  })
  }
}
