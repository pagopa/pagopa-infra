locals {
  tools_cae_name = var.env_short == "d" ? "${local.product}-${var.location_short}-core-spoke-tools-cae" : "${local.product}-${var.location_short}-core-tools-cae"
  tools_cae_rg   = "${local.product}-${var.location_short}-core-tools-rg"
}

module "gh_runner_job" {
  source = "./.terraform/modules/__v4__/gh_runner_container_app_job_domain_setup"

  domain_name        = var.domain
  env_short          = var.env_short
  environment_name   = local.tools_cae_name
  environment_rg     = local.tools_cae_rg
  gh_identity_suffix = "job-01"
  gh_env             = var.env
  runner_labels      = ["self-hosted-job", var.env]
  gh_repositories = [
    {
      name : "pagopa-print-payment-notice-service",
      short_name : "print-not-svc"
    },
    {
      name : "pagopa-print-payment-notice-generator",
      short_name : "print-not-gen"
    },
    {
      name : "pagopa-print-payment-notice-functions",
      short_name : "print-not-fn"
    },
    {
      name : "pagopa-template-notice-pdf",
      short_name : "tpl-not-pdf"
    }
  ]
  job      = {}
  job_meta = {}
  key_vault = {
    name        = "${local.project}-kv"                      # Name of the KeyVault which stores PAT as secret
    rg          = "${local.project}-sec-rg"                  # Resource group of the KeyVault which stores PAT as secret
    secret_name = "pagopa-platform-domain-github-bot-cd-pat" # Data of the KeyVault which stores PAT as secret
  }
  kubernetes_deploy = {
    enabled      = true
    namespaces   = [kubernetes_namespace.namespace.metadata[0].name]
    cluster_name = "${local.product}-${var.location_short}-${var.instance}-aks"
    rg           = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
  }

  location                = var.location
  prefix                  = var.prefix
  resource_group_name     = data.azurerm_resource_group.identity_rg.name
  domain_security_rg_name = "${local.project}-sec-rg"
  tags                    = module.tag_config.tags

}
