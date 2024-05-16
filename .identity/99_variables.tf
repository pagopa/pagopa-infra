locals {
  github = {
    org        = "pagopa"
    repository = "pagopa-infra"
  }

  prefix         = "pagopa"
  domain         = "ci"
  location_short = "itn"
  product        = "${var.prefix}-${var.env_short}"

  app_name = "github-${local.github.org}-${local.github.repository}-${var.prefix}-${local.domain}-${var.env}-aks"

  container_app_environment = {
    name           = "${local.prefix}-${var.env_short}-${local.location_short}-core-tools-cae",
    resource_group = "${local.prefix}-${var.env_short}-${local.location_short}-core-tools-rg",
  }
}

variable "env" {
  type = string
}

variable "env_short" {
  type = string
}

variable "prefix" {
  type    = string
  default = "pagopa"
  validation {
    condition = (
    length(var.prefix) <= 6
    )
    error_message = "Max length is 6 chars."
  }
}

variable "github_repository_environment" {
  type = object({
    protected_branches     = bool
    custom_branch_policies = bool
    reviewers_teams        = list(string)
  })
  description = "GitHub Continuous Integration roles"
  default = {
    protected_branches     = false
    custom_branch_policies = true
    reviewers_teams        = ["pagopa-team-core"]
  }
}
