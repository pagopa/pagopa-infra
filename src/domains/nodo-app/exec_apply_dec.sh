 ./terraform.sh apply weu-dev  \
 -target=module.apim_nodo_dei_pagamenti_product_auth \
 -target=terraform_data.sha256_apim_nodo_dei_pagamenti_product_auth \
 -target=terraform_data.sha256_nuova_connettivita_policy \
 -target=azapi_resource.nuova_connettivita_policy \
 -target=terraform_data.sha256_start_payment_inbound_policy \
-target=azapi_resource.start_payment_inbound_policy \
-target="azurerm_api_management_api_version_set.node_for_psp_api_auth" \
-target="terraform_data.sha256_apim_node_for_psp_api_v1_auth" \
-target="module.apim_node_for_psp_api_v1_auth" \
-target="azurerm_api_management_named_value.ndp_eCommerce_trxId_ttl" \
-target="azurerm_api_management_named_value.ndp_nodo_fc_nav_ttl"


