terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.21.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.96.0"
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
