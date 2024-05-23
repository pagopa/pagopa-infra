data "azurerm_eventhub_authorization_rule" "notices_evt_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-evenhub-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-core-evh-meucci"
}
data "azurerm_eventhub_authorization_rule" "notices_evt_complete_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-complete-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-evenhub-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-complete-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-core-evh-meucci"
}
data "azurerm_eventhub_authorization_rule" "notices_evt_errors_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-notice-evt-errors-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-evenhub-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-errors-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-core-evh-meucci"
}


data "azurerm_cosmosdb_account" "notices_cosmos_account" {
  name                = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-cosmos-account"
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-db-rg"
}

data "azurerm_storage_account" "notices_storage_sa" {
  name                = replace("${var.prefix}-${var.domain}-notices", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-pdf-rg"
}

data "azurerm_storage_account" "templates_storage_sa" {
  name                = replace("${var.prefix}-${var.domain}-templates", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-pdf-rg"
}

data "azurerm_storage_account" "institutions_storage_sa" {
  name                = replace("${var.prefix}-${var.domain}-ci", "-", "")
  resource_group_name = "pagopa-${var.env_short}-${var.location_short}-${var.domain}-pdf-rg"
}

data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}
