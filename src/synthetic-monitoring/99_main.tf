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
  # v8.77.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=d6a9fb68aaaf3f07c70b12910ab4c92427a8a363"
}
