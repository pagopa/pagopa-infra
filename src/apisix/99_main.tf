terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 3.85.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "= 2.32.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "= 2.15.0"
    }

    terracurl = {
      source  = "devops-rob/terracurl"
      version = "= 1.2.1"
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

provider "kubernetes" {
  config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
}

provider "helm" {
  kubernetes {
    config_path = "${var.k8s_kube_config_path_prefix}/config-${local.aks_name}"
  }
}

provider "terracurl" {}
