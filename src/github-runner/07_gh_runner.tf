locals {
  # because westeurope does not support any other container app environment creation
  tools_cae_name = "${local.product}-tools-cae"
  tools_cae_rg   = "${local.product}-core-tools-rg"
}

module "gh_runner_job" {
  source = "./.terraform/modules/__v4__/gh_runner_container_app_job_domain_setup"

  domain_name                 = var.domain
  env_short                   = var.env_short
  environment_name            = local.tools_cae_name
  environment_rg              = local.tools_cae_rg
  gh_identity_suffix          = "job-01"
  gh_env                      = var.env
  runner_labels               = ["self-hosted-job", var.env]
  polling_interval_in_seconds = 10
  gh_repositories = [
    {
      name : "pagopa-infra",
      short_name : "pagopa-infra"
    }
  ]
  job = {
    name = var.domain
  }
  job_meta = {}
  key_vault = {
    name = data.azurerm_key_vault.key_vault.name
    # Name of the KeyVault which stores PAT as secret
    rg = data.azurerm_key_vault.key_vault.resource_group_name
    # Resource group of the KeyVault which stores PAT as secret
    secret_name = "gh-runner-job-pat"
    # Data of the KeyVault which stores PAT as secret
  }

  kubernetes_deploy = {
    enabled      = true
    namespaces   = ["all"]
    cluster_name = data.azurerm_kubernetes_cluster.aks.name
    rg           = data.azurerm_kubernetes_cluster.aks.resource_group_name
  }

  location                = var.gh_runner_job_location
  prefix                  = var.prefix
  resource_group_name     = data.azurerm_resource_group.identity_rg.name
  domain_security_rg_name = data.azurerm_key_vault.key_vault.resource_group_name
  tags                    = module.tag_config.tags
}
