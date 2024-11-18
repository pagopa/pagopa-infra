module "gh_runner_job" {
  source = "github.com/pagopa/terraform-azurerm-v3//gh_runner_container_app_job_domain_setup?ref=PAYMCLOUD-151"

  domain_name = ""
  env_short = ""
  environment_name = ""
  environment_rg = ""
  gh_repositories = []
  job = {}
  job_meta = {}
  key_vault = {}
  kubernetes_deploy = {}
  location = ""
  prefix = ""
  resource_group_name = ""


}
