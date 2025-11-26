resource "azurerm_api_management_user" "pagopa_core_usr" {
  user_id             = "pagopa-core-usr"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  first_name          = "pagoPa Core"
  last_name           = "Team Tech"
  email               = "pagopa-core@pagopa.it" # https://groups.google.com/a/pagopa.it/g/pagopa-core/about
  state               = "active"
}

resource "azurerm_api_management_group_user" "pagopa_core_usr_to_grp" {
  user_id             = azurerm_api_management_user.pagopa_core_usr.user_id
  group_name          = azurerm_api_management_group.pagopa_core_grp.name
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
}