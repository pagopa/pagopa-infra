data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"
}

# repos must be lower than 20 items
locals {
  repos_01 = [
    "pagopa-selfcare-ms-backoffice-backend",
    "pagopa-backoffice-external",
    "pagopa-selfcare-frontend"
  ]

  federations_01 = [
    for repo in local.repos_01 : {
      repository = repo
      subject    = var.env
    }
  ]

  federations_01_pr = [
    for repo in local.repos_01 : {
      repository = repo
      subject    = "pull_request"
    }
  ]

  # to avoid subscription Contributor -> https://github.com/microsoft/azure-container-apps/issues/35
  environment_cd_roles = {
    subscription = [
      "Contributor",
    ]
    resource_groups = {
      "${local.product}-${var.domain}-sec-rg" = [
        "Key Vault Reader"
      ],
      "${local.product}-${var.location_short}-${var.env}-aks-rg" = [
        "Contributor"
      ],
    }
  }
}

# create a module for each 20 repos
module "identity_cd_01" {
  source = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v7.45.0"
  # pagopa-<ENV><DOMAIN>-<COUNTER>-github-<PERMS>-identity
  prefix    = var.prefix
  env_short = var.env_short
  domain    = "${var.domain}-01"

  identity_role = "cd"

  github_federations = local.federations_01

  cd_rbac_roles = {
    subscription_roles = local.environment_cd_roles.subscription
    resource_groups    = local.environment_cd_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}


resource "azurerm_key_vault_access_policy" "gha_iac_managed_identities" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.identity_cd_01.identity_principal_id

  secret_permissions = ["Get", "List", "Set", ]

  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy"]

  storage_permissions = []
}

resource "null_resource" "github_runner_app_permissions_to_namespace_cd_01" {
  triggers = {
    aks_id               = data.azurerm_kubernetes_cluster.aks.id
    service_principal_id = module.identity_cd_01.identity_client_id
    namespace            = var.domain
    version              = "v2"
  }

  provisioner "local-exec" {
    command = <<EOT
      az role assignment create --role "Azure Kubernetes Service RBAC Admin" \
      --assignee ${self.triggers.service_principal_id} \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}

      az role assignment list --role "Azure Kubernetes Service RBAC Admin"  \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}
    EOT
  }

  provisioner "local-exec" {
    when    = destroy
    command = <<EOT
      az role assignment delete --role "Azure Kubernetes Service RBAC Admin" \
      --assignee ${self.triggers.service_principal_id} \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}
    EOT
  }

  depends_on = [
    module.identity_cd_01
  ]
}


# create a module for each 20 repos
module "identity_pr_01" {
  source    = "github.com/pagopa/terraform-azurerm-v3//github_federated_identity?ref=v8.18.0"
  prefix    = var.prefix
  env_short = var.env_short
  domain    = "${var.domain}-01-pr"

  identity_role = "cd"

  github_federations = local.federations_01_pr

  cd_rbac_roles = {
    subscription_roles = local.environment_cd_roles.subscription
    resource_groups    = local.environment_cd_roles.resource_groups
  }

  tags = var.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}


resource "azurerm_key_vault_access_policy" "gha_pr_iac_managed_identities" {
  key_vault_id = data.azurerm_key_vault.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.identity_pr_01.identity_principal_id

  secret_permissions = ["Get", "List", "Set", ]

  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions = [
    "Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy"
  ]

  storage_permissions = []
}
