terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.3"
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

# v10.35.0
module "__v4__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=ea557e9868f502b8840ea22a0d09ab64c26d7903"
}
