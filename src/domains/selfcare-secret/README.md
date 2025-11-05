# qi-secrets

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 3.0.2 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.116.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | <= 2.3.4 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | <= 2.33.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.3 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module___v3__"></a> [\_\_v3\_\_](#module\_\_\_v3\_\_) | git::https://github.com/pagopa/terraform-azurerm-v3 | 551a56a4bf841cd431b51ec951639e74260daf6a |
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | ./.terraform/modules/__v3__/key_vault | n/a |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.sops_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [external_external.terrasops](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_input_file"></a> [input\_file](#input\_input\_file) | secret json file | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_kv-certificate-permissions-read"></a> [kv-certificate-permissions-read](#input\_kv-certificate-permissions-read) | List of read certificate permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "GetIssuers",<br/>  "List",<br/>  "ListIssuers"<br/>]</pre> | no |
| <a name="input_kv-key-permissions-read"></a> [kv-key-permissions-read](#input\_kv-key-permissions-read) | List of read key permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "List"<br/>]</pre> | no |
| <a name="input_kv-secret-permissions-read"></a> [kv-secret-permissions-read](#input\_kv-secret-permissions-read) | List of read secret permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "List"<br/>]</pre> | no |
| <a name="input_kv-storage-permissions-read"></a> [kv-storage-permissions-read](#input\_kv-storage-permissions-read) | List of read storage permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "GetSAS",<br/>  "List",<br/>  "ListSAS"<br/>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of weu, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
