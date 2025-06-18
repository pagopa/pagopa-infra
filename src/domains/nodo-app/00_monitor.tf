data "azurerm_log_analytics_workspace" "log_analytics" {
  name                = var.log_analytics_workspace_name
  resource_group_name = var.log_analytics_workspace_resource_group_name
}

data "azurerm_application_insights" "application_insights" {
  name                = local.monitor_appinsights_name
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
}

data "azurerm_resource_group" "monitor_rg" {
  name = var.monitor_resource_group_name
}

data "azurerm_monitor_action_group" "slack" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "slacknodo" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_slack_name
}

data "azurerm_monitor_action_group" "email" {
  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_email_name
}

data "azurerm_monitor_action_group" "opsgenie" {
  count = var.env_short != "d" ? 1 : 0

  resource_group_name = var.monitor_resource_group_name
  name                = local.monitor_action_group_opsgenie_name
}

data "azurerm_monitor_action_group" "smo_opsgenie" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = var.monitor_resource_group_name
  name                = "SmoOpsgenie"
}

resource "azurerm_monitor_metric_alert" "aks_nodo_metrics" {
  name                = "${local.aks_name}-nodo-cron-pod_number"
  resource_group_name = var.monitor_resource_group_name
  scopes              = [data.azurerm_kubernetes_cluster.aks.id]
  description         = "Action will be triggered when Pod count nodo-cron is greater than 200."

  criteria {
    aggregation      = "Average"
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_pod_status_phase"
    operator         = "GreaterThan"
    threshold        = 200
    dimension {
      name     = "Namespace"
      operator = "Include"
      values   = ["nodo-cron"]
    }
    dimension {
      name     = "phase"
      operator = "Include"
      values   = ["Failed", "Pending"]
    }
  }
  action {
    action_group_id    = data.azurerm_monitor_action_group.slack.id
    webhook_properties = null
  }
  action {
    action_group_id    = azurerm_monitor_action_group.logic_app.id
    webhook_properties = null
  }
}

resource "azurerm_monitor_metric_alert" "aks_nodo_metrics_error" {
  name                = "${local.aks_name}-nodo-cron-pod_error"
  resource_group_name = var.monitor_resource_group_name
  scopes              = [data.azurerm_kubernetes_cluster.aks.id]
  description         = "Action will be triggered when Pod count nodo-cron is greater than 200."

  criteria {
    aggregation      = "Average"
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_pod_status_phase"
    operator         = "GreaterThan"
    threshold        = 30
    dimension {
      name     = "Namespace"
      operator = "Include"
      values   = ["nodo-cron"]
    }
    dimension {
      name     = "phase"
      operator = "Include"
      values   = ["Failed", "Pending"]
    }

  }

  action {
    action_group_id    = data.azurerm_monitor_action_group.slack.id
    webhook_properties = null
  }
  action {
    action_group_id    = azurerm_monitor_action_group.logic_app.id
    webhook_properties = null
  }
}


##################################
## NODO CRON JOB ALERT WORKFLOW ##
##################################
resource "azurerm_monitor_action_group" "logic_app" {
  name                = "LogicAppNodoCronJobs"
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  short_name          = "LANodoCron"

  logic_app_receiver {
    name                    = "LogicAppReceiver"
    callback_url            = azurerm_logic_app_trigger_http_request.trigger.callback_url
    resource_id             = azurerm_logic_app_workflow.logic.id
    use_common_alert_schema = true
  }
}


resource "azurerm_logic_app_workflow" "logic" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-logic-alert-cronjob-suspend"
  location            = var.location
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  workflow_parameters = var.workflow.workflow_parameters
  workflow_schema     = var.workflow.workflow_schema
  workflow_version    = var.workflow.workflow_version

  identity {
    type = "SystemAssigned"
  }

  tags = module.tag_config.tags
}



resource "azurerm_logic_app_trigger_http_request" "trigger" {
  name         = "TriggerHTTPS"
  method       = "POST"
  logic_app_id = azurerm_logic_app_workflow.logic.id
  schema       = <<SCHEMA
{}
SCHEMA
}

resource "azurerm_logic_app_action_http" "get_sha256" {
  name         = "GET latest SHA256"
  logic_app_id = azurerm_logic_app_workflow.logic.id
  method       = "GET"
  headers = {
    "Authorization" = "Bearer ${local.github.pat}"
  }

  uri = "https://api.github.com/repos/${local.github.org}/${local.github.repository}/git/refs/heads/main"
}

resource "azurerm_logic_app_action_http" "create_branch" {
  name         = "Create alert branch"
  logic_app_id = azurerm_logic_app_workflow.logic.id
  method       = "POST"
  headers = {
    "Accept"        = "application/vnd.github.everest-preview+json"
    "Authorization" = "Bearer ${local.github.pat}"
  }
  body = <<SCHEMA
{
  "ref": "refs/heads/@{variables('branchName')}",
  "sha": "@{body('${local.custom_action_schema.parse_json.name}')?['object']?['sha']}"
}
SCHEMA
  uri  = "https://api.github.com/repos/${local.github.org}/${local.github.repository}/git/refs"
  run_after {
    action_name   = local.custom_action_schema.init_branch_variable.name
    action_result = "Succeeded"
  }
}

resource "azurerm_logic_app_action_http" "delete_branch" {
  name         = "Delete alert branch"
  logic_app_id = azurerm_logic_app_workflow.logic.id
  method       = "DELETE"
  headers = {
    "Accept"               = "application/vnd.github+json"
    "Authorization"        = "Bearer ${local.github.pat}"
    "X-GitHub-Api-Version" = "2022-11-28"
  }

  body = ""

  uri = "https://api.github.com/repos/${local.github.org}/${local.github.repository}/git/refs/heads/@{variables('branchName')}"
  run_after {
    action_name   = local.custom_action_schema.wait.name
    action_result = "Succeeded"
  }
}

resource "azurerm_logic_app_action_custom" "custom" {
  for_each     = local.custom_action_schema
  body         = each.value.body
  logic_app_id = azurerm_logic_app_workflow.logic.id
  name         = each.value.name
}


data "azurerm_key_vault_secret" "github_pat" {
  name         = "bot-token-github"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

locals {
  github = {
    org        = "pagopa"
    repository = "pagopa-infra"
    pat        = data.azurerm_key_vault_secret.github_pat.value
  }

  custom_action_schema = {
    parse_json = {
      name = "Parse sha256 sum from main"
      body = <<BODY
{
  "type": "ParseJson",
  "inputs": {
    "content": "@body('GET latest SHA256')",
    "schema": {
      "properties": {
        "node_id": {
          "type": "string"
        },
        "object": {
          "properties": {
            "sha": {
              "type": "string"
            },
            "type": {
              "type": "string"
            },
            "url": {
              "type": "string"
            }
          },
          "type": "object"
        },
        "ref": {
          "type": "string"
        },
        "url": {
          "type": "string"
        }
      },
      "type": "object"
    }
  },
  "runAfter": {
    "GET latest SHA256": [
      "Succeeded"
    ]
  }
}
BODY
    }
    init_branch_variable = {
      name = "Initialize variables"
      body = <<BODY
{
  "type": "InitializeVariable",
  "inputs": {
    "variables": [
      {
        "name": "branchName",
        "type": "string",
        "value": "alert-suspend-cron-55FG123SD-@{convertFromUtc(utcNow(), 'W. Europe Standard Time', 'yyyyMMddHHmmss')}-dev"
      }
    ]
  },
  "runAfter": {
    "Parse sha256 sum from main": [
      "Succeeded"
    ]
  }
}
BODY
    }
    wait = {
      name = "Delay"
      body = <<BODY
{
  "type": "Wait",
  "inputs": {
    "interval": {
      "count": 10,
      "unit": "Second"
    }
  },
  "runAfter": {
    "Create alert branch": [
      "Succeeded"
    ]
  }
}
BODY
    }
  }
}
