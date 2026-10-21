terraform {
  required_version = ">= 1.6.0"
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
      version = "<= 3.2.3"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.33"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.16"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.26"
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

provider "postgresql" {
  host            = data.azurerm_postgresql_flexible_server.qa_postgresql.fqdn
  superuser       = false
  port            = 5432
  username        = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  password        = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value
  connect_timeout = 15
}

module "__v4__" {
  # https://github.com/pagopa/terraform-azurerm-v4/releases/tag/v10.25.0
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=0c7bdec9a6ec5bc89bff9f8ca2758ebfeebe6b9c"
}
