terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.30.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.30.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.0"
    }
    github = {
      source  = "integrations/github"
      version = "<= 5.12.0"
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

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

provider "azapi" {

}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}


module "__v3__" {
  # v8.98.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=4ac32cd6fb7d56e7be3b1c0dbcbf251f5b0cd199"
}
