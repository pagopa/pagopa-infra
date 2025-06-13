data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  resource_group_name = local.aks_resource_group_name
}

# repos must be lower than 20 items
locals {
  repos_01 = [
    "pagopa-shared-toolbox",
    "pagopa-platform-authorizer",
    "pagopa-platform-authorizer-config",
    "pagopa-iuvgenerator",
    "pagopa-infra",
    "pagopa-anonymizer",
  ]

  federations_01 = [
    for repo in local.repos_01 : {
      repository = repo
      subject    = var.env
    }
  ]

  # to avoid subscription Contributor -> https://github.com/microsoft/azure-container-apps/issues/35
  environment_cd_roles = {
    subscription = [
      "Contributor"
    ]
    resource_groups = {
      "${local.product}-${var.domain}-sec-rg" = [
        "Key Vault Reader"
      ],
      "${local.product}-${var.location_short}-${var.env}-aks-rg" = [
        "Contributor"
      ]
    }
  }
}

# create a module for each 20 repos
module "identity_cd_01" {
  source = "./.terraform/modules/__v3__/github_federated_identity"
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

  tags = module.tag_config.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}

module "workload_identity" {
  source = "./.terraform/modules/__v3__/kubernetes_workload_identity_init"

  workload_identity_name_prefix         = var.domain
  workload_identity_resource_group_name = local.aks_resource_group_name
  workload_identity_location            = var.location
}

resource "azurerm_key_vault_access_policy" "gha_iac_managed_identities" {
  key_vault_id = module.key_vault.id
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
