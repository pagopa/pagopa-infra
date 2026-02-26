terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "> 4.0.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 3.0.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.25.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
    local = {
      source = "hashicorp/local"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

module "__v4__" {
  # v9.2.1
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=2aacf6a67baf3e9618b9b58d70ab5692d316aa94"
}
