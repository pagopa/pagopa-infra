#!/bin/bash

set -e

# ==============================================================
# config topics
# ==============================================================


echo ">>>>>> 1"

az eventhubs eventhub delete \
-g pagopa-d-itn-observ-evh-rg \
-n "connect-cluster-offsets" \
--namespace-name pagopa-d-itn-observ-gpd-evh

echo ">>>>>> 2"

az eventhubs eventhub delete \
-g pagopa-d-itn-observ-evh-rg \
-n "connect-cluster-status" \
--namespace-name pagopa-d-itn-observ-gpd-evh

echo ">>>>>> 3"

az eventhubs eventhub delete \
-g pagopa-d-itn-observ-evh-rg \
-n "connect-cluster-configs" \
--namespace-name pagopa-d-itn-observ-gpd-evh

# ==============================================================
# logical topics
# ==============================================================

echo ">>>>>> 4"

az eventhubs eventhub delete \
-g pagopa-d-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_option" \
--namespace-name pagopa-d-itn-observ-gpd-evh

echo ">>>>>> 5"

az eventhubs eventhub delete \
-g pagopa-d-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_position" \
--namespace-name pagopa-d-itn-observ-gpd-evh

echo ">>>>>> 6"

az eventhubs eventhub delete \
-g pagopa-d-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.transfer" \
--namespace-name pagopa-d-itn-observ-gpd-evh
