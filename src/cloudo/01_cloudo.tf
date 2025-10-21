
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-cloudo-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "cloudo" {
  source = "git::https://github.com/pagopa/payments-ClouDO.git//src/core/iac?ref=55a105d25eff99be8b5352db72074c4a2e56cb4a"

  prefix                    = local.product
  env                       = var.env
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  service_plan_sku          = "B1"
  application_insights_name = data.azurerm_application_insights.app_insight.name
  application_insights_rg   = data.azurerm_application_insights.app_insight.resource_group_name

  github_repo_info = {
    repo_name    = "pagopa/payments-cloudo"
    repo_branch  = "main"
    repo_token   = ""
    runbook_path = "src/runbooks"
  }

  aks_integration = {
    weu = {
      cluster_id = data.azurerm_kubernetes_cluster.aks_weu.id
    },
    itn = {
      cluster_id = data.azurerm_kubernetes_cluster.aks_itn.id
    }
  }

  app_service_logs = {
    retention_period_days = 3
    disk_quota_mb         = 35
  }

  slack_integration = {
    channel = ""
    token   = ""
  }

  opsgenie_api_key = ""


  schemas = file("${path.module}/env/${var.env}/schemas.json.tpl")

  orchestrator_image = {
    image_name        = "pagopa/cloudo-orchestrator"
    image_tag         = "0.2.1"
    registry_url      = "https://ghcr.io"
    registry_username = "payments-cloud-bot"
    registry_password = data.azurerm_key_vault_secret.github_pat.value
  }

  worker_image = {
    image_name        = "pagopa/cloudo-worker"
    image_tag         = "0.1.1"
    registry_url      = "https://ghcr.io"
    registry_username = "payments-cloud-bot"
    registry_password = data.azurerm_key_vault_secret.github_pat.value
  }

  tags = module.tag_config.tags
}

