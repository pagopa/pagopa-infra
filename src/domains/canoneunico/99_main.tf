terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.12.1"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.6.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.45.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.4.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.2"
    }
    time = {
      source  = "hashicorp/time"
      version = "<= 0.10.0"
    }

  }

  backend "azurerm" {}
}

provider "azapi" {
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

locals {
  project = "${var.prefix}-${var.env_short}"
}
