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
      name : "pagopa-gpd-upload",
      short_name : "gpd-upload"
    },
    {
      name : "pagopa-gpd-upload-function",
      short_name : "gpd-upload-fn"
    },
    {
      name : "pagopa-gpd-payments-pull",
      short_name : "gpd-pay-pull"
    },
    {
      name : "pagopa-gps-donation-service",
      short_name : "gpd-donation"
    },
    {
      name : "pagopa-gpd-payments",
      short_name : "gpd-payments"
    },
    {
      name : "pagopa-gpd-reporting-batch",
      short_name : "gpd-rpt-batch"
    },
    {
      name : "pagopa-gpd-reporting-analysis",
      short_name : "gpd-rpt-an"
    },
    {
      name : "pagopa-gpd-reporting-service",
      short_name : "gpd-rpt-svc"
    },
    {
      name : "pagopa-gpd-ingestion-manager"
      short_name : "gpd-ingst-mgr"
    },
    {
      name : "pagopa-reporting-orgs-enrollment"
      short_name : "gpd-rep-org"
    },
    {
      name : "pagopa-spontaneous-payments"
      short_name : "gpd-spopaym"
    },
    {
      name : "pagopa-debt-position"
      short_name : "gpd-debt-pos"
    },
    {
      name : "pagopa-gpd-rtp"
      short_name : "gpd-rtp"
    }
  ]
  job = {
    name = var.domain
  }
  job_meta = {}
  key_vault = {
    # name        = "${local.product}-kv"     # Name of the KeyVault which stores PAT as secret
    # rg          = "${local.product}-sec-rg" # Resource group of the KeyVault which stores PAT as secret
    # secret_name = "gh-runner-job-pat"       # Data of the KeyVault which stores PAT as secret
    name        = "${local.product}-${var.domain}-kv"        # Name of the KeyVault which stores PAT as secret
    rg          = "${local.product}-${var.domain}-sec-rg"    # Resource group of the KeyVault which stores PAT as secret
    secret_name = "pagopa-platform-domain-github-bot-cd-pat" # Data of the KeyVault which stores PAT as secret    
  }
  container = var.container_cusmtom_image
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
