terraform {
  required_version = ">=1.3.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.38.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.30.0"
    }
    github = {
      source  = "integrations/github"
      version = "5.12.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "github" {
  owner = var.github.org
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}
