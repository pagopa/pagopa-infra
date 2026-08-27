

module "gh_runner_job" {
  source = "./.terraform/modules/__v4__/gh_runner_container_app_job_domain_setup"

  domain_name        = local.domain
  env_short          = var.env_short
  environment_name   = local.gh_runner_cae_name
  environment_rg     = local.gh_runner_cae_rg
  gh_identity_suffix = "job-01"
  gh_env             = var.env
  runner_labels      = ["self-hosted-job", "${var.env}"]
  # FIXME: configure here the repositories to be used by the job
  gh_repositories = [

  ]
  job = {
    name = local.domain
  }
  job_meta = {}
  key_vault = {
    name        = local.gh_runner_pat_kv_name     # Name of the KeyVault which stores PAT as secret
    rg          = local.gh_runner_pat_kv_rg # Resource group of the KeyVault which stores PAT as secret
    secret_name = local.gh_runner_pat_key       # Data of the KeyVault which stores PAT as secret
  }

  kubernetes_deploy = {
    enabled      = true
    namespaces   = [kubernetes_namespace.namespace.metadata[0].name]
    cluster_name = local.aks_name
    rg           = local.aks_rg_name
  }

  location                = var.location
  prefix                  = local.prefix
  resource_group_name     = data.azurerm_resource_group.identity_rg.name
  domain_security_rg_name = "${local.project}-sec-rg"
  tags                    = module.tag_config.tags
}
