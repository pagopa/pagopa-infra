locals {
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
  runner_labels      = ["self-hosted-job"]
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
      azurerm_resource_group.gpd_rg.name
    ]
  }

  location            = var.location
  prefix              = var.prefix
  resource_group_name = data.azurerm_resource_group.identity_rg.name

  tags = var.tags

}
