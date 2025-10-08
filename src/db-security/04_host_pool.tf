resource "azurerm_resource_group" "vdi_rg" {
      count = var.enabled_features.db_vdi ? 1 : 0
  name     = "${local.project_vdi}-vdi-rg"
  location = var.db_vdi_settings.location

  tags = module.tag_config.tags
}


resource "azurerm_virtual_desktop_workspace" "workspace" {
      count = var.enabled_features.db_vdi ? 1 : 0
  name                = "${local.project_vdi}-vdi-workspace"
  location            = var.db_vdi_settings.location
  resource_group_name = azurerm_resource_group.vdi_rg[0].name

  friendly_name                 = "${var.env} ${var.location_short} DB VDI workspace"
  public_network_access_enabled = false


  tags = module.tag_config.tags
}

resource "azurerm_virtual_desktop_application_group" "application_group" {
  count = var.enabled_features.db_vdi ? 1 : 0
  name                = "${local.project_vdi}-vdi-application-group"
  location            = var.db_vdi_settings.location
  resource_group_name = azurerm_resource_group.vdi_rg[0].name

  type          = "Desktop"
  host_pool_id  = azurerm_virtual_desktop_host_pool.vdi_host_pool[0].id
  friendly_name = "Desktop"
  description   = "Desktop Application Group created via Terraform"

  default_desktop_display_name = "${local.project_vdi}-vdi-bridge"

  tags = module.tag_config.tags
}

resource "azurerm_virtual_desktop_workspace_application_group_association" "application_group_assignment" {
      count = var.enabled_features.db_vdi ? 1 : 0
  workspace_id         = azurerm_virtual_desktop_workspace.workspace[0].id
  application_group_id = azurerm_virtual_desktop_application_group.application_group[0].id
}

resource "azurerm_virtual_desktop_host_pool" "vdi_host_pool" {
  count = var.enabled_features.db_vdi ? 1 : 0
  name                = "${local.project_vdi}-vdi-hostpool"
  location            = var.db_vdi_settings.location
  resource_group_name = azurerm_resource_group.vdi_rg[0].name


  friendly_name            = "${var.prefix} ${var.env} VDI host pool"
  validate_environment     = true
  start_vm_on_connect      = true
  custom_rdp_properties    = "drivestoredirect:s:;audiomode:i:0;videoplaybackmode:i:0;redirectclipboard:i:0;redirectprinters:i:0;devicestoredirect:s:;redirectcomports:i:0;redirectsmartcards:i:0;usbdevicestoredirect:s:;enablecredsspsupport:i:1;redirectwebauthn:i:1;use multimon:i:1;enablerdsaadauth:i:1;"
  description              = "${var.prefix} ${var.location_short} host pool"
  type                     = var.db_vdi_settings.host_pool_type
  maximum_sessions_allowed = var.db_vdi_settings.session_limit
  load_balancer_type       = "BreadthFirst"
  preferred_app_group_type = "Desktop"
  scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = "Saturday"
      hour_of_day = 2
    }
  }

  tags = module.tag_config.tags

}


resource "azurerm_virtual_desktop_host_pool_registration_info" "host_pool_registration_info" {
  count = var.enabled_features.db_vdi ? 1 : 0
  hostpool_id     = azurerm_virtual_desktop_host_pool.vdi_host_pool[0].id
  expiration_date = timeadd(timestamp(), "2h")


}


resource "azurerm_role_assignment" "vdi_users" {
      count = var.enabled_features.db_vdi ? 1 : 0
  scope                = azurerm_virtual_desktop_application_group.application_group[0].id
  role_definition_name = "Desktop Virtualization Contributor"
  principal_id         = data.azuread_group.admin_group.object_id
}

resource "azurerm_role_assignment" "vdi_login" {
      count = var.enabled_features.db_vdi ? 1 : 0
  scope                = azurerm_resource_group.vdi_rg[0].id
  role_definition_name = "Virtual Machine User Login"
  principal_id         = data.azuread_group.admin_group.object_id
}


# Assigning this role at any level lower than your subscription, such as the resource group, host pool, or VM, will prevent Start VM on Connect from working properly.
# https://learn.microsoft.com/en-us/azure/virtual-desktop/start-virtual-machine-connect?tabs=azure-portal#assign-the-desktop-virtualization-power-on-contributor-role-with-the-azure-portal
resource "azurerm_role_assignment" "assign_power_on_role" {
      count = var.enabled_features.db_vdi ? 1 : 0
  scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}"
  role_definition_name = "Desktop Virtualization Power On Contributor"
  # this is the principal id for Azure Virtual Desktop managed identity, required to have this role to start the VMs
  principal_id = "ee655f2c-7cef-4f4d-8b6b-e5a0b8b2a556"
}
