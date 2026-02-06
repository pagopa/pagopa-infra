
resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-${var.env_short}-${var.location_short_ita}-cloudo-rg"
  location = var.location_ita

  tags = module.tag_config.tags
}

module "cloudo" {
  source = "git::https://github.com/pagopa/payments-ClouDO.git//src/core/iac?ref=2ae6d1f6b941cd31f7be508bb127fa944ed6e4f0"

  prefix                    = local.product
  product_name              = var.prefix
  env                       = var.env
  location                  = var.location_ita
  resource_group_name       = azurerm_resource_group.rg.name
  application_insights_name = data.azurerm_application_insights.app_insight.name
  application_insights_rg   = data.azurerm_application_insights.app_insight.resource_group_name
  subscription_id           = data.azurerm_subscription.current.subscription_id
  vnet_name                 = data.azurerm_virtual_network.network_tools_vnet.name
  vnet_rg                   = data.azurerm_virtual_network.network_tools_vnet.resource_group_name

  vpn_subnet_id                  = data.azurerm_subnet.vpn_subnet.id
  private_endpoint_dns_zone_name = data.azurerm_private_dns_zone.private_endpoint_dns_zone.name

  cloudo_google_sso_integration_client_id = data.azurerm_key_vault_secret.google_client_id.value

  github_repo_info = {
    repo_name    = "pagopa/pagopa-infra"
    repo_branch  = "main"
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

  approval_runbook = {
    ttl_min = "120"
  }

  slack_integration = {
    channel = "#cloudo-${var.prefix}-${var.env}"
    token   = data.azurerm_key_vault_secret.cloudo_slack_token.value
  }

  opsgenie_api_key = var.env_short == "p" ? data.azurerm_key_vault_secret.opsgenie_token.0.value : ""

  schemas = file("${path.module}/env/${var.env}/schemas.json.tpl")

  orchestrator_image = {
    image_name        = var.cloudo_orchestrator.image_name
    image_tag         = var.cloudo_orchestrator.image_tag
    registry_url      = var.cloudo_orchestrator.registry_url
    registry_username = var.cloudo_orchestrator.registry_username
    registry_password = data.azurerm_key_vault_secret.github_pat.value
  }

  workers_config = {
    workers = {
      "generic-worker" = "generic"
    }
    image_name        = var.cloudo_worker.image_name
    image_tag         = var.cloudo_worker.image_tag
    registry_url      = var.cloudo_worker.registry_url
    registry_username = var.cloudo_worker.registry_username
    registry_password = data.azurerm_key_vault_secret.github_pat.value
  }

  enable_ui = true
  ui_image = {
    image_name        = var.cloudo_ui.image_name
    image_tag         = var.cloudo_ui.image_tag
    registry_url      = var.cloudo_ui.registry_url
    registry_username = var.cloudo_ui.registry_username
    registry_password = data.azurerm_key_vault_secret.github_pat.value
  }

  tags = module.tag_config.tags
}

