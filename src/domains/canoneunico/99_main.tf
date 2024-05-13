terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.30.0, <= 3.53.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "= 2.6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = ">= 2.2.3"
    }

    time = {
      source  = "hashicorp/time"
      version = ">= 0.9.0"
    }
    azapi = {
      source = "Azure/azapi"
      # version = "= 1.3.0"
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
