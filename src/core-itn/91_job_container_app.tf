module "container_app_job_pagopa_infra" {
  source = "github.com/pagopa/terraform-azurerm-v3.git//container_app_job_gh_runner_v2?ref=job-container-app-v1"

  location  = var.location
  prefix    = var.prefix
  job_name_prefix = "prefix"
  env_short = var.env_short

  container_app_environment_name = azurerm_container_app_environment.tools_cae[0].name
  container_app_environment_rg_name = azurerm_container_app_environment.tools_cae[0].resource_group_name

  job = {
    name             = "pagopa-infra"
    repo             = "pagopa-infra"
    polling_interval = 20
  }

  tags = var.tags
}
