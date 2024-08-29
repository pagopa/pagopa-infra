terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.94.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.5.1"
    }
    time = {
      source  = "hashicorp/time"
      version = "<= 0.11.1"
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
