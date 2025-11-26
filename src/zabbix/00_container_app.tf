data "azurerm_container_app_environment" "tools_cae" {
  name                = local.tools_container_app_env
  resource_group_name = local.tools_container_app_env_rg
}
