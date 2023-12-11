# DISMISSIONE LMI
# DEV DONE
# UAT DONE
# PROD
sh terraform.sh apply prod \
-target=module.apim_nodo_ppt_lmi_product \
-target=azurerm_api_management_api_version_set.nodo_ppt_lmi_api \
-target=module.apim_nodo_ppt_lmi_api \
-target=module.apim_nodo_ppt_lmi_dev_product \
-target=azurerm_api_management_api_version_set.nodo_ppt_lmi_dev_api \
-target=module.apim_nodo_ppt_lmi_dev_api \
-target=azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_dev

# DISMISSIONE PSP-FOR-NODE
# DEV DONE
# UAT DONE
# PROD
sh terraform.sh apply uat \
-target=azurerm_api_management_api_version_set.psp_for_node_api \
-target=azurerm_api_management_api.apim_psp_for_node_api_v1 \
-target=azurerm_api_management_api_policy.apim_psp_for_node_policy \
-target=azurerm_api_management_api_version_set.psp_for_node_api_auth \
-target=azurerm_api_management_api.apim_psp_for_node_api_v1_auth \
-target=azurerm_api_management_api_policy.apim_psp_for_node_policy_auth \
-target=azurerm_api_management_api_version_set.psp_for_node_api_dev \
-target=azurerm_api_management_api.apim_psp_for_node_api_v1_dev \
-target=azurerm_api_management_api_policy.apim_psp_for_node_policy_dev


# DISMISSIONE ALL-IN-ONE
# DEV DONE
# UAT DONE
# PROD
sh terraform.sh apply uat \
-target=module.apim_nodo_oncloud_product \
-target=module.apim_nodo_oncloud_api \
-target=module.apim_nodo_oncloud_dev_product \
-target=azurerm_api_management_api_version_set.nodo_oncloud_dev_api \
-target=module.apim_nodo_oncloud_dev_api



##############

# CREAZIONE NAMED VALUE
# DEV DONE
# UAT DONE
# PROD
sh terraform.sh apply uat \
-target=azurerm_api_management_named_value.schema_ip_nexi \
-target=azurerm_api_management_named_value.schema_ip_nodo_postgresql_pagopa \
-target=azurerm_api_management_named_value.default_nodo_backend \
-target=azurerm_api_management_named_value.default_nodo_backend_prf \
-target=azurerm_api_management_named_value.default_nodo_backend_dev_nexi \
-target=azurerm_api_management_named_value.default_nodo_id \
-target=azurerm_api_management_named_value.enable_nm3_decoupler_switch \
-target=azurerm_api_management_named_value.enable_routing_decoupler_switch

##############
# DECOUPLER
sh terraform.sh apply uat \
-target=null_resource.decoupler_configuration_from_json_2_xml

sh terraform.sh apply dev \
-target=azapi_resource.decoupler_algorithm \
-target=azapi_resource.decoupler_activate_outbound \
-target=azapi_resource.decoupler_configuration \
-target=azurerm_api_management_named_value.node_decoupler_primitives \
-target=azapi_resource.on_erro_soap_handler

sh terraform.sh apply uat \
-target=module.apim_nodo_dei_pagamenti_product_auth \
-target=azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_auth \
-target=azurerm_api_management_named_value.nodo_auth_password_value \
-target=azurerm_api_management_named_value.x_forwarded_for_value \
-target=azurerm_api_management_api_version_set.node_for_psp_api_auth \
-target=azurerm_api_management_api.apim_node_for_psp_api_v1_auth \
-target=azurerm_api_management_api_policy.apim_node_for_psp_policy_auth \
-target=azurerm_api_management_api_operation_policy.nm3_activate_verify_policy_auth \
-target=azurerm_api_management_api_operation_policy.nm3_activate_v2_verify_policy_auth \
-target=azurerm_api_management_api_version_set.nodo_per_psp_api_auth \
-target=azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth \
-target=azurerm_api_management_api_policy.apim_nodo_per_psp_policy_auth \
-target=azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_auth \
-target=azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth \
-target=azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy_auth \
-target=azurerm_api_management_api_version_set.node_for_io_api_auth \
-target=azurerm_api_management_api.apim_node_for_io_api_v1_auth \
-target=azurerm_api_management_api_policy.apim_node_for_io_policy_auth \
-target=azurerm_api_management_api_version_set.nodo_per_pa_api_auth \
-target=azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth \
-target=azurerm_api_management_api_policy.apim_nodo_per_pa_policy_auth \
-target=azurerm_api_management_api_version_set.node_for_pa_api_auth \
-target=azurerm_api_management_api.apim_node_for_pa_api_v1_auth \
-target=azurerm_api_management_api_policy.apim_node_for_pa_policy_auth \
-target=module.apim_nodo_dei_pagamenti_product \
-target=azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api \
-target=azurerm_api_management_api_version_set.node_for_psp_api \
-target=azurerm_api_management_api.apim_node_for_psp_api_v1 \
-target=azurerm_api_management_api_policy.apim_node_for_psp_policy \
-target=azurerm_api_management_api_operation_policy.nm3_activate_verify_policy \
-target=azurerm_api_management_api_operation_policy.nm3_activate_v2_verify_policy \
-target=azurerm_api_management_api_version_set.nodo_per_psp_api \
-target=azurerm_api_management_api.apim_nodo_per_psp_api_v1 \
-target=azurerm_api_management_api_policy.apim_nodo_per_psp_policy \
-target=azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api \
-target=azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1 \
-target=azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy \
-target=azurerm_api_management_api_version_set.node_for_io_api \
-target=azurerm_api_management_api.apim_node_for_io_api_v1 \
-target=azurerm_api_management_api_policy.apim_node_for_io_policy \
-target=azurerm_api_management_api_operation_policy.activateIO_reservation_policy \
-target=azurerm_api_management_api_version_set.nodo_per_pa_api \
-target=azurerm_api_management_api.apim_nodo_per_pa_api_v1 \
-target=azurerm_api_management_api_policy.apim_nodo_per_pa_policy \
-target=azurerm_api_management_api_version_set.nodo_per_pm_api \
-target=module.apim_nodo_per_pm_api_v1 \
-target=azurerm_api_management_api_operation_policy.close_payment_api_v1 \
-target=azurerm_api_management_api_operation_policy.parked_list_api_v1 \
-target=module.apim_nodo_per_pm_api_v2 \
-target=module.apim_nodo_dei_pagamenti_product_dev \
-target=azurerm_api_management_product_api.apim_nodo_dei_pagamenti_product_api_dev \
-target=azurerm_api_management_api_version_set.node_for_psp_api_dev \
-target=azurerm_api_management_api.apim_node_for_psp_api_v1_dev \
-target=azurerm_api_management_api_policy.apim_node_for_psp_policy_dev \
-target=azurerm_api_management_api_version_set.nodo_per_psp_api_dev \
-target=azurerm_api_management_api.apim_nodo_per_psp_api_v1_dev \
-target=azurerm_api_management_api_policy.apim_nodo_per_psp_policy_dev \
-target=azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_dev \
-target=azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_dev \
-target=azurerm_api_management_api_policy.apim_nodo_per_psp_richiesta_avvisi_policy_dev \
-target=azurerm_api_management_api_version_set.node_for_io_api_dev \
-target=azurerm_api_management_api.apim_node_for_io_api_v1_dev \
-target=azurerm_api_management_api_policy.apim_node_for_io_policy_dev \
-target=azurerm_api_management_api_version_set.nodo_per_pa_api_dev \
-target=azurerm_api_management_api.apim_nodo_per_pa_api_v1_dev \
-target=azurerm_api_management_api_policy.apim_nodo_per_pa_policy_dev \
-target=azurerm_api_management_api_version_set.nodo_per_pm_api_dev \
-target=module.apim_nodo_per_pm_api_v1_dev \
-target=azurerm_api_management_api_operation_policy.close_payment_api_v1_dev \
-target=azurerm_api_management_api_operation_policy.parked_list_api_v1_dev \
-target=module.apim_nodo_per_pm_api_v2_dev

#### MONITORING
sh terraform.sh apply uat \
-target=azurerm_api_management_api_version_set.nodo_monitoring_api_dev \
-target=module.apim_nodo_monitoring_api_dev \
-target=module.apim_nodo_dei_pagamenti_monitoring_product \
-target=azurerm_api_management_api_version_set.nodo_monitoring_api \
-target=module.apim_nodo_monitoring_api

#### APP SATELLITI
sh terraform.sh apply uat \
-target=module.apim_nodo_sync_product \
-target=azurerm_api_management_api_version_set.nodo_sync_api \
-target=module.apim_nodo_sync_api \
-target=module.apim_nodo_wfesp_product \
-target=azurerm_api_management_api_version_set.nodo_wfesp_api \
-target=module.apim_nodo_wfesp_api \
-target=module.apim_nodo_fatturazione_product \
-target=azurerm_api_management_api_version_set.nodo_fatturazione_api \
-target=module.apim_nodo_fatturazione_api \
-target=module.apim_nodo_web_bo_product \
-target=module.apim_nodo_web_bo_api \
-target=module.apim_nodo_web_bo_api_onprem \
-target=module.apim_nodo_web_bo_product_history \
-target=module.apim_nodo_web_bo_api_history \
-target=module.apim_nodo_web_bo_api_onprem_history \
-target=module.apim_nodo_sync_dev_product \
-target=azurerm_api_management_api_version_set.nodo_sync_dev_api \
-target=module.apim_nodo_sync_dev_api \
-target=module.apim_nodo_wfesp_dev_product \
-target=azurerm_api_management_api_version_set.nodo_wfesp_dev_api \
-target=module.apim_nodo_wfesp_dev_api \
-target=module.apim_nodo_fatturazione_dev_product \
-target=azurerm_api_management_api_version_set.nodo_fatturazione_dev_api \
-target=module.apim_nodo_fatturazione_dev_api \
-target=module.apim_nodo_web_bo_dev_product \
-target=module.apim_nodo_web_bo_dev_api \
-target=module.apim_nodo_web_bo_dev_product_history \
-target=module.apim_nodo_web_bo_dev_api_history




# Non applicare
# NODO PER PM
sh terraform.sh apply dev \
-target=azurerm_api_management_api_version_set.nodo_per_pm_api \
-target=module.apim_nodo_per_pm_api_v1 \
-target=azurerm_api_management_api_operation_policy.close_payment_api_v1 \
-target=azurerm_api_management_api_operation_policy.parked_list_api_v1 \
-target=module.apim_nodo_per_pm_api_v2 \
-target=azurerm_api_management_api_version_set.nodo_per_pm_api_dev \
-target=module.apim_nodo_per_pm_api_v1_dev \
-target=azurerm_api_management_api_operation_policy.close_payment_api_v1_dev \
-target=azurerm_api_management_api_operation_policy.parked_list_api_v1_dev \
-target=module.apim_nodo_per_pm_api_v2_dev

