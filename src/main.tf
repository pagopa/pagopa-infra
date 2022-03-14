terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.87.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.6.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.13.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
