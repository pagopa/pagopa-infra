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

resource "azurerm_data_factory_dataset_json" "afm_gec_bundle_cdc_json" {
  name                = "PDND_CDC_GEC_BUNDLES_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name

  azure_blob_storage_location {
    container = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
    path      = "bundles"
    filename  = ""
  }

  encoding    = "UTF-8"
  folder      = local.folder
  annotations = []
}

resource "azurerm_data_factory_dataset_json" "afm_gec_cibundle_cdc_json" {
  name                = "PDND_CDC_GEC_CIBUNDLES_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name

  azure_blob_storage_location {
    container = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
    path      = "cibundles"
    filename  = ""
  }

  encoding    = "UTF-8"
  folder      = local.folder
  annotations = []
}

resource "azurerm_data_factory_dataset_json" "afm_gec_touchpoints_cdc_json" {
  name                = "PDND_CDC_GEC_TOUCHPOINTS_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name

  azure_blob_storage_location {
    container = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
    path      = "touchpoints"
    filename  = ""
  }

  encoding    = "UTF-8"
  folder      = local.folder
  annotations = []
}

resource "azurerm_data_factory_dataset_json" "afm_gec_paymenttypes_cdc_json" {
  name                = "PDND_CDC_GEC_PAYMENTTYPES_JSON_Dataset"
  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
  linked_service_name = azurerm_data_factory_linked_service_azure_blob_storage.afm_gec_storage_linked_service.name

  azure_blob_storage_location {
    container = "pagopa-${var.env_short}-itn-observ-az-blob-observability-container"
    path      = "paymenttypes"
    filename  = ""
  }

  encoding    = "UTF-8"
  folder      = local.folder
  annotations = []
}


#resource "azurerm_data_factory_dataset_postgresql" "crusc8_payment_receipt" {
#  name                = "CRUSC8_PAGOPA_PAYMENT_RECEIPT"
#  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
#  linked_service_name = "LinkedService-Cruscotto"
#  table_name          = "cruscotto.pagopa_payment_receipt"
#}

#resource "azurerm_data_factory_dataset_postgresql" "crusc8_recorded_timeout" {
#  name                = "CRUSC8_PAGOPA_PAYMENT_RECEIPT"
#  data_factory_id     = data.azurerm_data_factory.obeserv_data_factory.id
#  linked_service_name = "LinkedService-Cruscotto"
#  table_name          = "cruscotto.pagopa_recorded_timeout"
#}

resource "azurerm_data_factory_custom_dataset" "crusc8_tables_datasets" {
  for_each             = { for ds in local.crusc8_tables_list_datasets : ds.dataset_name => ds }
  name                 = each.key
  data_factory_id      = data.azurerm_data_factory.obeserv_data_factory.id
  type                 = "AzurePostgreSqlTable"
  type_properties_json = <<JSON
      { 
      "schema" : "${each.value.schema_name}",
      "table"  : "${each.value.table_name}"
    }
    JSON

  schema_json = file(each.value.dataset_schema_file)

  linked_service {
    name = "LinkedService-Cruscotto"
  }
}

resource "azurerm_data_factory_custom_dataset" "cfg_tables_list_datasets" {
  for_each             = { for ds in local.cfg_tables_list_datasets : ds.dataset_name => ds }
  name                 = each.key
  data_factory_id      = data.azurerm_data_factory.obeserv_data_factory.id
  type                 = "AzurePostgreSqlTable"
  type_properties_json = <<JSON
      { 
      "schema" : "${each.value.schema_name}",
      "table"  : "${each.value.table_name}"
    }
    JSON

  schema_json = file(each.value.dataset_schema_file)

  linked_service {
    name = "LinkedService-Nodo-Flexible"
  }
}
