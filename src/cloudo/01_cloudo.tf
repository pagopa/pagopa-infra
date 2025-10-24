
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-cloudo-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "cloudo" {
  source = "git::https://github.com/pagopa/payments-ClouDO.git//src/core/iac?ref=47d6b92700eac281c7a90ab9eb05785666ae9da5"

  prefix                    = local.product
  env                       = var.env
  location                  = var.location
  resource_group_name       = azurerm_resource_group.rg.name
  service_plan_sku          = "B1"
  application_insights_name = data.azurerm_application_insights.app_insight.name
  application_insights_rg   = data.azurerm_application_insights.app_insight.resource_group_name
  subscription_id           = data.azurerm_subscription.current.subscription_id

  github_repo_info = {
    repo_name    = "pagopa/pagopa-infra"
    repo_branch  = "main"
    repo_token   = "PAYMCLOUD-541-cloudo-first-deploy-on-pagopa-dev-subscription"
    runbook_path = "src/cloudo/runbooks"
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
    channel = "#cloudo-test"
    token   = data.azurerm_key_vault_secret.cloudo_slack_token.value
  }

  opsgenie_api_key = var.env_short == "p" ? data.azurerm_key_vault_secret.opsgenie_token.0.value : ""


  schemas = file("${path.module}/env/${var.env}/schemas.json.tpl")

  orchestrator_image = {
    image_name        = "pagopa/cloudo-orchestrator"
    image_tag         = "0.2.4"
    registry_url      = "https://ghcr.io"
    registry_username = "payments-cloud-bot"
    registry_password = data.azurerm_key_vault_secret.github_pat.value
  }

  worker_image = {
    image_name        = "pagopa/cloudo-worker"
    image_tag         = "0.1.6"
    registry_url      = "https://ghcr.io"
    registry_username = "payments-cloud-bot"
    registry_password = data.azurerm_key_vault_secret.github_pat.value
  }

  tags = module.tag_config.tags
}

