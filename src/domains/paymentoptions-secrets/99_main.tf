terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 3.0.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.3"
    }
    external = {
      source  = "hashicorp/external"
      version = "<= 2.3.4"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.33.0"
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

module "__v3__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=15bbe5eb512bc0fa8f06ed28e0cca754b868743a"
}
