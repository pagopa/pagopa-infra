terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 3.0.2"
    }
    github = {
      source  = "integrations/github"
      version = "5.18.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.3.2"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

provider "github" {
  owner = "pagopa"
}

module "__v3__" {
  # v8.91.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=179dddb9c85e412da5e807b430322155f30aeda5"
}
