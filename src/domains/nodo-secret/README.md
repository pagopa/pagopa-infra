# nodo-secret

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.30.0, <= 3.53.0 |
| <a name="requirement_external"></a> [external](#requirement\_external) | = 2.2.3 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | = 2.5.1 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | = 2.11.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | = 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_key_vault"></a> [key\_vault](#module\_key\_vault) | git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault | v6.4.1 |
| <a name="module_nodocerts_sa"></a> [nodocerts\_sa](#module\_nodocerts\_sa) | git::https://github.com/pagopa/terraform-azurerm-v3.git//storage_account | v7.18.0 |
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.ad_group_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_developers_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.adgroup_externals_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_app_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_legacy_policies](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_managed_identities](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.azdevops_iac_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.generated](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_key_vault_secret.secret](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_secret) | resource |
| [azurerm_resource_group.sec_rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_share.firmatore](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share) | resource |
| [kubernetes_config_map.nodo_cacerts](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/config_map) | resource |
| [kubernetes_config_map.nodo_cron_cacerts](https://registry.terraform.io/providers/hashicorp/kubernetes/2.11.0/docs/resources/config_map) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/client_config) | data source |
| [azuread_group.adgroup_admin](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_developers](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_externals](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_group.adgroup_security](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/group) | data source |
| [azuread_service_principal.iac_deploy_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_plan_legacy](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/service_principal) | data source |
| [azuread_service_principal.iac_principal](https://registry.terraform.io/providers/hashicorp/azuread/2.30.0/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [azurerm_user_assigned_identity.app_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [azurerm_user_assigned_identity.iac_federated_azdo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity) | data source |
| [external_external.external](https://registry.terraform.io/providers/hashicorp/external/2.2.3/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_az_nodo_sa_share_name_firmatore"></a> [az\_nodo\_sa\_share\_name\_firmatore](#input\_az\_nodo\_sa\_share\_name\_firmatore) | Azure storage account share name | `string` | n/a | yes |
| <a name="input_cacerts_path"></a> [cacerts\_path](#input\_cacerts\_path) | Java cacerts | `string` | n/a | yes |
| <a name="input_certs_storage_account_replication_type"></a> [certs\_storage\_account\_replication\_type](#input\_certs\_storage\_account\_replication\_type) | (Optional) Certificates storage account replication type | `string` | `"LRS"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_enable_iac_pipeline"></a> [enable\_iac\_pipeline](#input\_enable\_iac\_pipeline) | If true create the key vault policy to allow used by azure devops iac pipelines. | `bool` | `false` | no |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_input_file"></a> [input\_file](#input\_input\_file) | secret json file | `string` | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | One of beta, prod01, prod02 | `string` | n/a | yes |
| <a name="input_k8s_kube_config_path_prefix"></a> [k8s\_kube\_config\_path\_prefix](#input\_k8s\_kube\_config\_path\_prefix) | n/a | `string` | `"~/.kube"` | no |
| <a name="input_kv-certificate-permissions-read"></a> [kv-certificate-permissions-read](#input\_kv-certificate-permissions-read) | List of read certificate permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "GetIssuers",<br/>  "List",<br/>  "ListIssuers"<br/>]</pre> | no |
| <a name="input_kv-key-permissions-read"></a> [kv-key-permissions-read](#input\_kv-key-permissions-read) | List of read key permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "List"<br/>]</pre> | no |
| <a name="input_kv-secret-permissions-read"></a> [kv-secret-permissions-read](#input\_kv-secret-permissions-read) | List of read secret permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "List"<br/>]</pre> | no |
| <a name="input_kv-storage-permissions-read"></a> [kv-storage-permissions-read](#input\_kv-storage-permissions-read) | List of read storage permissions | `list(string)` | <pre>[<br/>  "Get",<br/>  "GetSAS",<br/>  "List",<br/>  "ListSAS"<br/>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of weu, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_name"></a> [log\_analytics\_workspace\_name](#input\_log\_analytics\_workspace\_name) | Specifies the name of the Log Analytics Workspace. | `string` | n/a | yes |
| <a name="input_log_analytics_workspace_resource_group_name"></a> [log\_analytics\_workspace\_resource\_group\_name](#input\_log\_analytics\_workspace\_resource\_group\_name) | The name of the resource group in which the Log Analytics workspace is located in. | `string` | n/a | yes |
| <a name="input_monitor_resource_group_name"></a> [monitor\_resource\_group\_name](#input\_monitor\_resource\_group\_name) | Monitor resource group name | `string` | n/a | yes |
| <a name="input_nodo_cert_storage_account"></a> [nodo\_cert\_storage\_account](#input\_nodo\_cert\_storage\_account) | n/a | <pre>object({<br/>    advanced_threat_protection    = bool<br/>    blob_delete_retention_days    = number<br/>    blob_versioning_enabled       = bool<br/>    public_network_access_enabled = bool<br/>    backup_enabled                = bool<br/>    backup_retention              = optional(number, 0)<br/>  })</pre> | <pre>{<br/>  "advanced_threat_protection": false,<br/>  "backup_enabled": false,<br/>  "backup_retention": 0,<br/>  "blob_delete_retention_days": 30,<br/>  "blob_versioning_enabled": false,<br/>  "public_network_access_enabled": false<br/>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | general | `string` | n/a | yes |
| <a name="input_upload_firmatore"></a> [upload\_firmatore](#input\_upload\_firmatore) | n/a | `map(string)` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
