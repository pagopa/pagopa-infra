#!/bin/bash

set -e

# ==============================================================
# config topics
# ==============================================================

env=$1

echo ">>>>>> 1"

az eventhubs eventhub delete \
-g pagopa-$env-itn-observ-evh-rg \
-n "connect-cluster-offsets" \
--namespace-name pagopa-$env-itn-observ-gpd-evh

echo ">>>>>> 2"

az eventhubs eventhub delete \
-g pagopa-$env-itn-observ-evh-rg \
-n "connect-cluster-status" \
--namespace-name pagopa-$env-itn-observ-gpd-evh

echo ">>>>>> 3"

az eventhubs eventhub delete \
-g pagopa-$env-itn-observ-evh-rg \
-n "connect-cluster-configs" \
--namespace-name pagopa-$env-itn-observ-gpd-evh

# ==============================================================
# logical topics
# ==============================================================

echo ">>>>>> 4"

az eventhubs eventhub delete \
-g pagopa-$env-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_option" \
--namespace-name pagopa-$env-itn-observ-gpd-evh

echo ">>>>>> 5"

az eventhubs eventhub delete \
-g pagopa-$env-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_position" \
--namespace-name pagopa-$env-itn-observ-gpd-evh

echo ">>>>>> 6"

az eventhubs eventhub delete \
-g pagopa-$env-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.transfer" \
--namespace-name pagopa-$env-itn-observ-gpd-evh
