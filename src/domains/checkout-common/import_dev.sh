#!/bin/bash
# Generated with `generate_imports.py`

# module.pagopa_proxy_redis_snet
echo 'Importing module.pagopa_proxy_redis_snet.azurerm_subnet.this'
./terraform.sh import weu-dev 'module.pagopa_proxy_redis_snet.azurerm_subnet.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-d-vnet/subnets/pagopa-d-pagopa-proxy-redis-snet'


# resource.azurerm_resource_group.pagopa_proxy_rg
echo 'Importing azurerm_resource_group.pagopa_proxy_rg'
./terraform.sh import weu-dev 'azurerm_resource_group.pagopa_proxy_rg' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-pagopa-proxy-rg'


# module.pagopa_proxy_redis
echo 'Importing module.pagopa_proxy_redis.azurerm_private_endpoint.this[0]'
./terraform.sh import weu-dev 'module.pagopa_proxy_redis.azurerm_private_endpoint.this[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-pagopa-proxy-rg/providers/Microsoft.Network/privateEndpoints/pagopa-d-pagopa-proxy-redis-private-endpoint'


# module.pagopa_proxy_redis
echo 'Importing module.pagopa_proxy_redis.azurerm_redis_cache.this'
./terraform.sh import weu-dev 'module.pagopa_proxy_redis.azurerm_redis_cache.this' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-pagopa-proxy-rg/providers/Microsoft.Cache/Redis/pagopa-d-pagopa-proxy-redis'


# resource.azurerm_dns_zone.checkout_public[0]
echo 'Importing azurerm_dns_zone.checkout_public[0]'
./terraform.sh import weu-dev 'azurerm_dns_zone.checkout_public[0]' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/dnszones/dev.checkout.pagopa.it'


# resource.azurerm_dns_caa_record.checkout_pagopa_it
echo 'Importing azurerm_dns_caa_record.checkout_pagopa_it'
./terraform.sh import weu-dev 'azurerm_dns_caa_record.checkout_pagopa_it' '/subscriptions/bbe47ad4-08b3-4925-94c5-1278e5819b86/resourceGroups/pagopa-d-vnet-rg/providers/Microsoft.Network/dnszones/dev.checkout.pagopa.it/CAA/@'


echo 'Import executed succesfully on dev environment! ⚡'
