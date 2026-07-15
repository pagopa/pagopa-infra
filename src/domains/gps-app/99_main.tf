terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 3.0.2"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.116.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.16.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.30.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.3"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
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

provider "azapi" {
  skip_provider_registration = true
}

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}

provider "kubectl" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

module "__v3__" {
  # v8.103.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=d0a0b3a81963169bdc974f79eba31e41e918e63d"
}
