terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.11.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.21.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 4.0.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
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

module "__v3__" {
  # v8.95.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=af5980583baf38b7d796a7afa3b82ced1fe369d2"
}
