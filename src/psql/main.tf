terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.76.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.3.0"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "= 1.14.0"
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
