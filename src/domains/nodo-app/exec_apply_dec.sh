 ./terraform.sh apply weu-dev  \
-target="azurerm_api_management_named_value.ndp_eCommerce_trxId_ttl" \
-target="azurerm_api_management_named_value.ndp_nodo_fc_nav_ttl" \
-target=module.apim_nodo_dei_pagamenti_product_auth \
-target=terraform_data.sha256_apim_nodo_dei_pagamenti_product_auth \
-target=terraform_data.sha256_nuova_connettivita_policy \
-target=azapi_resource.nuova_connettivita_policy \
-target=terraform_data.sha256_start_payment_inbound_policy \
-target=azapi_resource.start_payment_inbound_policy \
-target="azurerm_api_management_api_version_set.node_for_psp_api_auth" \
-target="terraform_data.sha256_apim_node_for_psp_api_v1_auth" \
-target="module.apim_node_for_psp_api_v1_auth" \
-target="terraform_data.sha256_extract_fc_nav_policy" \
-target=azapi_resource.extract_fc_nav_policy \
-target=terraform_data.sha256_verifyPaymentNotice_v1_policy_auth \
-target=azurerm_api_management_api_operation_policy.verifyPaymentNotice_v1_policy_auth \
-target=terraform_data.sha256_activePaymentNotice_v1_policy_auth \
-target=azurerm_api_management_api_operation_policy.activePaymentNotice_v1_policy_auth \
-target=terraform_data.sha256_verificatore_inbound_policy \
-target=azapi_resource.verificatore_inbound_policy \
-target=terraform_data.sha256_verificatore_outbound_policy \
-target=azapi_resource.verificatore_outbound_policy \
-target=terraform_data.sha256_wisp_activate_inbound_policy \
-target=azapi_resource.wisp_activate_inbound_policy \
-target=terraform_data.sha256_wisp_activate_outbound_policy \
-target=azapi_resource.wisp_activate_outbound_policy


