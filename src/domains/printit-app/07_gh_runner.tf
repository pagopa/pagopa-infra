locals {
  tools_cae_name = "${local.product}-${var.location_short}-core-tools-cae"
  tools_cae_rg   = "${local.product}-${var.location_short}-core-tools-rg"
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
      azurerm_resource_group.printit_pdf_engine_app_service_rg.name
    ]
  }

  location            = var.location
  prefix              = var.prefix
  resource_group_name = data.azurerm_resource_group.identity_rg.name

  tags = var.tags

}