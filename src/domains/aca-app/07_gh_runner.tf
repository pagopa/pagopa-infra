locals {
  tools_cae_name = "${local.product}-tools-cae"
  tools_cae_rg = "${local.product}-core-tools-rg"
}

module "gh_runner_job" {
  source = "github.com/pagopa/terraform-azurerm-v3//gh_runner_container_app_job_domain_setup?ref=PAYMCLOUD-151" #fixme tag ref

  domain_name = "aca"
  env_short = var.env_short
  environment_name = local.tools_cae_name
  environment_rg = local.tools_cae_rg
  gh_repositories = [
    {
      name: "pagopa-payment-options-service", #FIXME configure aca repos
      short_name: "aca"
    }
  ]
  job = {
    name = "aca"
  }
  job_meta = {}
  key_vault = {
    name        = "${local.product}-kv" # Name of the KeyVault which stores PAT as secret
    rg          = "${local.product}-sec-rg" # Resource group of the KeyVault which stores PAT as secret
    secret_name = "gh-runner-job-pat" # Data of the KeyVault which stores PAT as secret
  }
  kubernetes_deploy = {
    enabled      = true
    namespaces    = [kubernetes_namespace.namespace.metadata[0].name]
    cluster_name = "${local.product}-${var.location_short}-${var.instance}-aks"
    rg           = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
  }

  location = var.location
  prefix = var.prefix
  resource_group_name = data.azurerm_resource_group.identity_rg.name

  tags = var.tags

}
