data "azurerm_cosmosdb_account" "notices_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-db-rg"
}

data "azurerm_storage_account" "notices_storage_sa" {
  name                = replace("${var.domain}-notices", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_storage_account" "templates_storage_sa" {
  name                = replace("${var.domain}-templates", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_storage_account" "institutions_storage_sa" {
  name                = replace("${var.domain}-institutions", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-rg"
}

data "azurerm_application_insights" "application_insights" {
  name                = "pagopa-${var.env_short}-appinsights"
  resource_group_name = var.monitor_resource_group_name
}
