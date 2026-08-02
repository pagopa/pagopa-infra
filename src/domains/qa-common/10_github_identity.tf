data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

# repos must be lower than 20 items
locals {
  repos_01 = [
    "pagopa-platform-mcp",
    "pagopa-qa-centralhub-backend",
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

  environment_cd_roles = {
    subscription = [
      "Contributor",
    ]
    resource_groups = {
      "${local.product}-${var.location_short}-${local.domain}-sec-rg" = [
        "Key Vault Reader"
      ],
      "${local.product}-${var.location_short}-${var.env}-aks-rg" = [
        "Contributor"
      ],
    }
  }
}

module "identity_cd_01" {
  source = "./.terraform/modules/__v4__/github_federated_identity"
  # pagopa-<ENV_SHORT><DOMAIN>-<COUNTER>-github-<PERMS>-identity
  prefix    = local.prefix
  env_short = var.env_short
  domain    = "${local.domain}-01"

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

# pagopa-platform-mcp uses GitHub's new numeric-ID subject format; add extra federated credentials
data "azurerm_user_assigned_identity" "identity_cd_01" {
  name                = module.identity_cd_01.identity_app_name
  resource_group_name = module.identity_cd_01.identity_resource_group
}

resource "azurerm_federated_identity_credential" "mcp_cd_env_secure" {
  name                = "pagopa-platform-mcp-cd-environment-${var.env}-secure"
  resource_group_name = module.identity_cd_01.identity_resource_group
  parent_id           = data.azurerm_user_assigned_identity.identity_cd_01.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  subject             = "repo:pagopa@57742367/pagopa-platform-mcp@1315113194:environment:${var.env}"
}

resource "azurerm_federated_identity_credential" "mcp_pr_secure" {
  name                = "pagopa-platform-mcp-cd-pull-request-secure"
  resource_group_name = module.identity_cd_01.identity_resource_group
  parent_id           = data.azurerm_user_assigned_identity.identity_cd_01.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = "https://token.actions.githubusercontent.com"
  subject             = "repo:pagopa@57742367/pagopa-platform-mcp@1315113194:pull_request"
}

resource "azurerm_key_vault_access_policy" "gha_cd_iac_managed_identities" {
  key_vault_id = data.azurerm_key_vault.domain_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.identity_cd_01.identity_principal_id

  secret_permissions      = ["Get", "List", "Set"]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy"]
  storage_permissions     = []
}

resource "null_resource" "github_runner_app_permissions_to_namespace_cd_01" {
  triggers = {
    aks_id               = data.azurerm_kubernetes_cluster.aks.id
    service_principal_id = module.identity_cd_01.identity_client_id
    namespace            = local.domain
    version              = "v2"
  }

  provisioner "local-exec" {
    command = <<EOT
      az role assignment create --role "Azure Kubernetes Service RBAC Admin" \
      --assignee ${self.triggers.service_principal_id} \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}

      az role assignment list --role "Azure Kubernetes Service RBAC Admin" \
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

module "identity_pr_01" {
  source    = "./.terraform/modules/__v4__/github_federated_identity"
  prefix    = local.prefix
  env_short = var.env_short
  domain    = "${local.domain}-01-pr"

  identity_role = "cd"

  github_federations = local.federations_01_pr

  cd_rbac_roles = {
    subscription_roles = local.environment_cd_roles.subscription
    resource_groups    = local.environment_cd_roles.resource_groups
  }

  tags = module.tag_config.tags

  depends_on = [
    data.azurerm_resource_group.identity_rg
  ]
}

resource "azurerm_key_vault_access_policy" "gha_pr_iac_managed_identities" {
  key_vault_id = data.azurerm_key_vault.domain_kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.identity_pr_01.identity_principal_id

  secret_permissions      = ["Get", "List", "Set"]
  certificate_permissions = ["SetIssuers", "DeleteIssuers", "Purge", "List", "Get"]
  key_permissions         = ["Get", "List", "Update", "Create", "Import", "Delete", "Encrypt", "Decrypt", "GetRotationPolicy"]
  storage_permissions     = []
}

resource "null_resource" "github_runner_app_permissions_to_namespace_pr_01" {
  triggers = {
    aks_id               = data.azurerm_kubernetes_cluster.aks.id
    service_principal_id = module.identity_pr_01.identity_client_id
    namespace            = local.domain
    version              = "v2"
  }

  provisioner "local-exec" {
    command = <<EOT
      az role assignment create --role "Azure Kubernetes Service RBAC Admin" \
      --assignee ${self.triggers.service_principal_id} \
      --scope ${self.triggers.aks_id}/namespaces/${self.triggers.namespace}

      az role assignment list --role "Azure Kubernetes Service RBAC Admin" \
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
    module.identity_pr_01
  ]
}
