locals {
  # because westeurope does not support any other container app environment creation
  tools_cae_name = var.env_short != "p" ? "${local.product}-tools-cae" : "${local.product}-itn-core-tools-cae"
  tools_cae_rg   = var.env_short != "p" ? "${local.product}-core-tools-rg" : "${local.product}-itn-core-tools-rg"
}

module "gh_runner_job" {
  source = "./.terraform/modules/__v3__/gh_runner_container_app_job_domain_setup"

  domain_name        = var.domain
  env_short          = var.env_short
  environment_name   = local.tools_cae_name
  environment_rg     = local.tools_cae_rg
  gh_identity_suffix = "job-01"
  gh_env             = var.env
  runner_labels      = ["self-hosted-job", "${var.env}"]
  gh_repositories = [
    {
      name : "pagopa-fdr-nodo-dei-pagamenti", # FdR-1
      short_name : "fdr-ndp"
    },
    {
      name : "pagopa-fdr", # FdR-3
      short_name : "fdr"
    }
  ]
  job = {
    name = var.domain
  }
  job_meta = {}
  key_vault = {
    name        = "${local.product}-kv"     # Name of the KeyVault which stores PAT as secret
    rg          = "${local.product}-sec-rg" # Resource group of the KeyVault which stores PAT as secret
    secret_name = "gh-runner-job-pat"       # Data of the KeyVault which stores PAT as secret
  }
  kubernetes_deploy = {
    enabled      = true
    namespaces   = [kubernetes_namespace.namespace.metadata[0].name]
    cluster_name = "${local.product}-${var.location_short}-${var.instance}-aks"
    rg           = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
  }

  function_deploy = {
    enabled = true
    function_rg = [
      azurerm_resource_group.reporting_fdr_rg.name,
      data.azurerm_resource_group.fdr_re_rg.name,
      data.azurerm_resource_group.fdr_rg.name,
    ]
  }

  location            = var.gh_runner_job_location
  prefix              = var.prefix
  resource_group_name = data.azurerm_resource_group.identity_rg.name

  tags = var.tags

}
