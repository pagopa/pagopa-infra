 ./terraform.sh apply weu-dev  \
 -target=module.apim_nodo_dei_pagamenti_product_auth \
 -target=terraform_data.sha256_apim_nodo_dei_pagamenti_product_auth \
 -target=terraform_data.sha256_nuova_connettivita_policy \
 -target=azapi_resource.nuova_connettivita_policy
