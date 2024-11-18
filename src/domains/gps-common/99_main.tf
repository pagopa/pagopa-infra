terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.13.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.47.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.107.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.2"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

module "__v3__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=v8.52.0"
}