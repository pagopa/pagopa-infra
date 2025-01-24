### variables
variable "partition_count_map" {
  default = {
    prod = 32
    uat = 1
    dev = 1
  }
}

variable "message_retention_map" {
  default = {
    prod = 7
    uat = 2
    dev = 2
  }
}

### resource group definition
resource "azurerm_resource_group" "qi_evh_resource_group" {
  name     = "pagopa-${var.env_short}-itn-qi-evh-rg"
  location = "Italy North"
}

### namespace definition
resource "azurerm_eventhub_namespace" "qi_evh_namespace" {
  name                = "pagopa-${var.env_short}-itn-qi-evh"
  location            = azurerm_resource_group.qi_evh_resource_group.location
  resource_group_name = azurerm_resource_group.qi_evh_resource_group.name
  sku                 = "Standard"
  capacity            = 1

  auto_inflate_enabled     = true
  maximum_throughput_units = 1
}

### event hub definition 
resource "azurerm_eventhub" "qi_evh_bdi_kpi_ingestion_dl" {
  name                = "bdi-kpi-ingestion-dl"
  #namespace_id        = azurerm_eventhub_namespace.qi_evh_namespace.name
  resource_group_name = azurerm_resource_group.qi_evh_resource_group.name
  namespace_name      = azurerm_eventhub_namespace.qi_evh_namespace.name
  partition_count     = var.partition_count_map[var.env]
  message_retention   = var.message_retention_map[var.env]
  status              = "Active"
}

### shared access policies
resource "azurerm_eventhub_authorization_rule" "qi_evh_sas_bdi_kpi_evt_tx" {
  name                = "bdi-kpi-evt-tx" 
  namespace_name      = azurerm_eventhub_namespace.qi_evh_namespace.name
  eventhub_name       = azurerm_eventhub.qi_evh_bdi_kpi_ingestion_dl.name
  resource_group_name = azurerm_resource_group.qi_evh_resource_group.name

  # grant
  listen = false
  send   = true
  manage = false
}