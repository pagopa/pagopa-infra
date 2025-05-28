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

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}


module "__v3__" {
  # v8.96.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v3?ref=3c0fe5bea7ad6cea223a7e319055639bae2cffc5"
}
