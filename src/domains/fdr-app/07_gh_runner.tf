locals {
  # because westeurope does not support any other container app environment creation
  tools_cae_name = "${local.product}-tools-cae"
  tools_cae_rg   = "${local.product}-core-tools-rg"
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
    },
    {
      name : "pagopa-fdr-2-event-hub",
      short_name : "fdr2evh"
    },
    {
      name : "pagopa-fdr-xml-to-json",
      short_name : "fdr-xml2json"
    },
    {
      name : "pagopa-fdr-json-to-xml",
      short_name : "fdr-json2xml"
    },
    {
      name : "pagopa-fdr-technical-support",
      short_name : "fdr-tech"
    }
  ]
  job = {
    name = var.domain
  }
  job_meta = {}
  key_vault = {
    name        = "${local.product}-${var.domain}-kv"     # Name of the KeyVault which stores PAT as secret
    rg          = "${local.product}-${var.domain}-sec-rg" # Resource group of the KeyVault which stores PAT as secret
    secret_name = "pagopa-platform-domain-github-bot-cd-pat"       # Data of the KeyVault which stores PAT as secret
  }
  kubernetes_deploy = {
    enabled      = true
    namespaces   = [kubernetes_namespace.namespace.metadata[0].name]
    cluster_name = "${local.product}-${var.location_short}-${var.instance}-aks"
    rg           = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
  }


  location                = var.gh_runner_job_location
  prefix                  = var.prefix
  resource_group_name     = data.azurerm_resource_group.identity_rg.name
  domain_security_rg_name = "${local.product}-${var.domain}-sec-rg"
  tags                    = module.tag_config.tags

}
