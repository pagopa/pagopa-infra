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
  # v8.64.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=ff49c94c7bfb8f2867e550483d8acc125bf516a7"
}
