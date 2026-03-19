terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.26.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.47.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "<= 2.2.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.30"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.12.1"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  skip_provider_registration = true
  features {
    key_vault {
      purge_soft_delete_on_destroy = false
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}

module "__v4__" {
  # v9.2.1
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=2aacf6a67baf3e9618b9b58d70ab5692d316aa94"
}
