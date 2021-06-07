terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 2.56.0"
    }
  }

  # terraform cloud.
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "PagoPa"
    workspaces {
      prefix = "pagopa-"
    }
  }
}
provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {
}

locals {
  project = format("%s-%s", var.prefix, var.env_short)
}
