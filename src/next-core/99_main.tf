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
  # v10.4.1
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=7daabc5d931b095b03e12a3f911fa89d4bf6d1c0"
}
