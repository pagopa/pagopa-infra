#!/bin/bash
# Generated with `generate_imports.py`

# module.pagopa_proxy_redis_snet
echo 'Importing module.pagopa_proxy_redis_snet.azurerm_subnet.this'
./terraform.sh import weu-uat 'module.pagopa_proxy_redis_snet.azurerm_subnet.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-u-vnet/subnets/pagopa-u-pagopa-proxy-redis-snet'


# resource.azurerm_resource_group.pagopa_proxy_rg
echo 'Importing azurerm_resource_group.pagopa_proxy_rg'
./terraform.sh import weu-uat 'azurerm_resource_group.pagopa_proxy_rg' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-pagopa-proxy-rg'


# module.pagopa_proxy_redis
echo 'Importing module.pagopa_proxy_redis.azurerm_private_endpoint.this[0]'
./terraform.sh import weu-uat 'module.pagopa_proxy_redis.azurerm_private_endpoint.this[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-pagopa-proxy-rg/providers/Microsoft.Network/privateEndpoints/pagopa-u-pagopa-proxy-redis-private-endpoint'


# module.pagopa_proxy_redis
echo 'Importing module.pagopa_proxy_redis.azurerm_redis_cache.this'
./terraform.sh import weu-uat 'module.pagopa_proxy_redis.azurerm_redis_cache.this' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-pagopa-proxy-rg/providers/Microsoft.Cache/Redis/pagopa-u-pagopa-proxy-redis'


# resource.azurerm_dns_zone.checkout_public[0]
echo 'Importing azurerm_dns_zone.checkout_public[0]'
./terraform.sh import weu-uat 'azurerm_dns_zone.checkout_public[0]' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-vnet-rg/providers/Microsoft.Network/dnszones/uat.checkout.pagopa.it'


# resource.azurerm_dns_caa_record.checkout_pagopa_it
echo 'Importing azurerm_dns_caa_record.checkout_pagopa_it'
./terraform.sh import weu-uat 'azurerm_dns_caa_record.checkout_pagopa_it' '/subscriptions/26abc801-0d8f-4a6e-ac5f-8e81bcc09112/resourceGroups/pagopa-u-vnet-rg/providers/Microsoft.Network/dnszones/uat.checkout.pagopa.it/CAA/@'


echo 'Import executed succesfully on uat environment! ⚡'
