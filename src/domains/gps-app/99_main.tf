terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "<= 1.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "<= 2.21.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.45.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "<= 2.5.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "<= 2.11.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "<= 3.2.1"
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

module "__v3__" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=15bbe5eb512bc0fa8f06ed28e0cca754b868743a"
}