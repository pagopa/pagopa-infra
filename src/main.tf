terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.92.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.6.0"
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
