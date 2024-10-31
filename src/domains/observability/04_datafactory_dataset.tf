locals {
  datasets = { for filename in fileset(path.module, "datafactory/datasets/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
  # datasets = { for filename in fileset(path.module, "datafactory/${var.env_short == "p" ? "NOT_FOUND" : "datasets"}/*.json") : replace(basename(filename), ".json", "") => file("${path.module}/${filename}") }
  folder = "PDND_CDC_GEC_DATASETS"
}

data "azurerm_data_factory" "qi_data_factory" {
  name                = "pagopa-${var.env_short}-weu-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-weu-nodo-df-rg"
}

resource "azurerm_data_factory_custom_dataset" "qi_datasets" {
  depends_on      = [azurerm_data_factory_linked_service_kusto.dataexp_ls[0]]
  for_each        = local.datasets
  name            = "SMO_${each.key}_DataSet"
  data_factory_id = data.azurerm_data_factory.qi_data_factory.id
  type            = "AzureDataExplorerTable"

  type_properties_json = file("datafactory/datasets/type_properties/${each.key}.json")

  schema_json = <<JSON
      ${each.value}
  JSON

  linked_service {
    name = azurerm_data_factory_linked_service_kusto.dataexp_ls[0].name
  }

}

############# CDC INGESTION GEC DATASETS #################################
data "azurerm_data_factory" "obeserv_data_factory" {
  name                = "pagopa-${var.env_short}-${var.location_short}-nodo-df"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-nodo-df-rg"
}

resource "azurerm_data_factory_dataset_azure_blob" "pdnd_cdc_gec_bundles_json" {
  name                = "PDND_CDC_GEC_BUNDLES_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name
  path                = "bundles"
  folder              = local.folder
}

resource "azurerm_data_factory_dataset_azure_blob" "pdnd_cdc_gec_cibundles_json" {
  name                = "PDND_CDC_GEC_CIBUNDLES_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name
  path                = "cibundles"
  folder              = local.folder
}

resource "azurerm_data_factory_dataset_azure_blob" "pdnd_cdc_gec_touchpoints_json" {
  name                = "PDND_CDC_GEC_TUCHPOINTS_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name
  path                = "touchpoints"
  folder              = local.folder
}

resource "azurerm_data_factory_dataset_azure_blob" "pdnd_cdc_gec_paymenttypes_json" {
  name                = "PDND_CDC_GEC_PAYMENTTYPES_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name
  path                = "paymenttypes"
  folder              = local.folder
}

# name                = "PDND_CDC_GEC_BUNDLES_JSON_Dataset"
# path                = "bundles"

# name                = "PDND_CDC_GEC_CIBUNDLES_JSON_Dataset"
# path                = "cibundles"

# name                = "PDND_CDC_GEC_TUCHPOINTS_JSON_Dataset"
# path                = "touchpoints"

# name                = "PDND_CDC_GEC_PAYMENTTYPES_JSON_Dataset"
# path                = "paymenttypes"
resource "azurerm_data_factory_custom_dataset" "pdnd_cdc_gec_bundles_json" {
  name                = "PDND_CDC_GEC_BUNDLES_JSON_Dataset_"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  type                = "Json"

  type_properties_json = <<JSON
  "location": {
      "type": "AzureBlobStorageLocation",
      "folderPath": "bundles",
      "container": "pagopa-d-itn-observ-az-blob-observability-container"
  }  
  JSON

  schema_json = <<JSON
  {}
  JSON

  linked_service {
    name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name
  }

  folder              = local.folder
}
