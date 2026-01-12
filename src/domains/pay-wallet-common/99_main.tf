terraform {
  required_version = ">= 1.6"
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
      version = "<= 3.3.2"
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

module "__v4__" {
  # v8.1.1
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=7e40a22"
}
