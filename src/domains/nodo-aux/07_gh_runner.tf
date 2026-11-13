locals {
  # because westeurope does not support any other container app environment creation
  tools_cae_name = "${local.product}-tools-cae"
  tools_cae_rg   = "${local.product}-core-tools-rg"
}

module "gh_runner_job" {
  source = "./.terraform/modules/__v4__/gh_runner_container_app_job_domain_setup"

  domain_name        = var.domain
  env_short          = var.env_short
  environment_name   = local.tools_cae_name
  environment_rg     = local.tools_cae_rg
  gh_identity_suffix = "aux-job-01"
  gh_env             = var.env
  runner_labels      = ["self-hosted-job", var.env]
  gh_repositories = [
    {
      org_id = "57742367"
      name : "pagopa-nodo-observability",
      repository_id : "1446965331"
      short_name : "nodo-obs"
    }
  ]
  job = {
    name                 = var.domain
    scale_max_executions = 1
  }
  job_meta = {}
  key_vault = {
    name        = "${local.product}-${var.domain}-kv"        # Name of the KeyVault which stores PAT as secret
    rg          = "${local.product}-${var.domain}-sec-rg"    # Resource group of the KeyVault which stores PAT as secret
    secret_name = "pagopa-platform-domain-github-bot-cd-pat" # Data of the KeyVault which stores PAT as secret
  }
  kubernetes_deploy = {
    enabled      = true
    namespaces   = [kubernetes_namespace.namespace.metadata[0].name]
    cluster_name = "${local.product}-${var.location_short}-${var.instance}-aks"
    rg           = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
  }

  prefix                  = var.prefix
  resource_group_name     = data.azurerm_resource_group.identity_rg.name
  domain_security_rg_name = "${local.product}-${var.domain}-sec-rg"

  tags                    = module.tag_config.tags
}
