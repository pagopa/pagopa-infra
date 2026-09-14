terraform {
  required_version = ">= 1.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.16"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 3.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.35"
    }
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "~> 1.21"
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

provider "postgresql" {
  host      = module.postgres_flexible_server_qa.fqdn
  port      = 5432
  username  = data.azurerm_key_vault_secret.pgres_flex_admin_login.value
  password  = data.azurerm_key_vault_secret.pgres_flex_admin_pwd.value
  superuser = false
  sslmode   = "require"
}

module "__v4__" {
  # https://github.com/pagopa/terraform-azurerm-v4/releases/tag/v10.28.1
  source = "git::https://github.com/pagopa/terraform-azurerm-v4?ref=a3fa1dc231a570d3e97c811f01cbe5547adafbdc"
}