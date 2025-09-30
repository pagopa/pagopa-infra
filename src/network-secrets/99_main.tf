terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.47.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    external = {
      source  = "hashicorp/external"
      version = "<= 2.3.3"
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

provider "kubernetes" {
  config_path    = "~/.kube/config-${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks"
  config_context = "${var.prefix}-${var.env_short}-${var.location_short}-${var.env}-aks"
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

module "__v4__" {
  # v7.36.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=3cd8cf7653ea0889761fbb8403c28097c086f50c"
}
