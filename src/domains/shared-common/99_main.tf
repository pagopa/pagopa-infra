terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.1"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.39.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.30.0"
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
