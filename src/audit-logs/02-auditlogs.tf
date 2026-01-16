module "azure_auditlogs" {

  source                     = "git::https://github.com/pagopa/terraform-azure-auditlogs?ref=PAYMCLOUD-633_auditlogs_output_eventhub"
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
    rg_name       = local.log_analytics_italy_workspace_resource_group_name
    export_tables = ["ContainerLog"], # change to appropriate log analytics table
  }


  stream_analytics_job = {
    name                 = "${local.project}-job",
    transformation_query = "../../../transformation_query.sql",
  }

  data_explorer = {
    name           = "${local.project}-dec",
    sku_name       = "Dev(No SLA)_Standard_E2a_v4",
    sku_capacity   = 1,
    reader_groups  = [data.azuread_group.adgroup_security.object_id, data.azuread_group.adgroup_operations.object_id, data.azuread_group.adgroup_technical_project_managers.object_id],
    admin_groups   = [data.azuread_group.adgroup_admin.object_id, data.azuread_group.adgroup_developers.object_id],
    script_content = "../../../external_table.sql",
  }

  tags = var.tags
}

resource "azurerm_log_analytics_data_export_rule" "export_to_eventhub_weu" {
  for_each = toset(["ContainerLog"])

  name                    = each.value
  resource_group_name     = local.log_analytics_weu_workspace_resource_group_name
  workspace_resource_id   = data.azurerm_log_analytics_workspace.log_analytics_weu.id
  destination_resource_id = module.azure_auditlogs.eventhub_id
  table_names             = [each.value]
  enabled                 = true
}

resource "azurerm_stream_analytics_function_javascript_udf" "parsejson" {
  name                      = "parseJson"
  stream_analytics_job_name = "${local.project}-job"
  resource_group_name       = azurerm_resource_group.rg.name

  script = <<SCRIPT
function parseJson(string) {
try {
return JSON.parse(string);
} catch (error) {
  return {"audit":"false"};
}
}
SCRIPT


  input {
    type = "any"
  }

  output {
    type = "any"
  }
}