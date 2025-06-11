terraform {
  required_version = ">= 1.6"
  required_providers {
     azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.25.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "<= 3.4.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "<= 4.0.4"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}


module "__v4__" {
  # 7.2.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4.git?ref=5c38b6fc6e2aa2c2c3e94be5dd6bb6ee8d690a49"
}
