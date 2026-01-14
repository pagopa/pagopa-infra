module "azure_auditlogs" {

  source                     = "git::https://github.com/pagopa/terraform-azure-auditlogs?ref=v1.1.1"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = var.location
  debug                      = false # true only for test use, set to false in production envs
  subnet_private_endpoint_id = module.endpoint_snet.id

  storage_account = {
    name_temp                          = replace("${local.project}tmpst", "-", ""),
    name_immutable                     = replace("${local.project}immst", "-", ""),
    immutability_policy_retention_days = 1,          # change to required retention
    immutability_policy_state          = "Unlocked", # change to Locked after first apply
  }

  event_hub = {
    namespace_name = "${local.project}-evhns",
    sku_name       = "Standard", # change to Premium for mission critical applications
  }

  log_analytics_workspace = {
    id            = data.azurerm_log_analytics_workspace.log_analytics.id,
    export_tables = ["AppEvents"], # change to appropriate log analytics table
  }
  log_analytics_workspace_rg_name = local.log_analytics_italy_workspace_resource_group_name

  stream_analytics_job = {
    name = "${local.project}-job",
  }

  data_explorer = {
    name          = "${local.project}-dec",
    sku_name      = "Dev(No SLA)_Standard_E2a_v4",
    sku_capacity  = 1,
    reader_groups = [data.azuread_group.adgroup_security.object_id, data.azuread_group.adgroup_operations.object_id, data.azuread_group.adgroup_technical_project_managers.object_id],
    admin_groups  = [data.azuread_group.adgroup_admin.object_id, data.azuread_group.adgroup_developers.object_id],
  }

  tags = var.tags
}
