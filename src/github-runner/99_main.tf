terraform {
  required_version = "~> 1.9"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4"
    }
    null = {
      source  = "hashicorp/null"
      version = "= 3.1.1"
    }
    local = {
      source = "hashicorp/local"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

module "__v4__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=1cb98ae738621c9ab30cd46cea33cdc91e06993f" # v6.17.0
}
