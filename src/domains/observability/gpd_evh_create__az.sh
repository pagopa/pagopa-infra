#!/bin/bash

set -e

# ==============================================================
# config topics
# ==============================================================


# echo ">>>>>> 1"

# az eventhubs eventhub create \
# -g pagopa-d-itn-observ-evh-rg \
# -n "connect-cluster-offsets" \
# --namespace-name pagopa-d-itn-observ-gpd-evh \
# --cleanup-policy "Compact" \
# --status "Active" \
# --partition-count 1 \
# --retention-time 24

# echo ">>>>>> 2"

# az eventhubs eventhub create \
# -g pagopa-d-itn-observ-evh-rg \
# -n "connect-cluster-status" \
# --namespace-name pagopa-d-itn-observ-gpd-evh \
# --cleanup-policy "Compact" \
# --status "Active" \
# --partition-count 1 \
# --retention-time 24

# echo ">>>>>> 3"

# az eventhubs eventhub create \
# -g pagopa-d-itn-observ-evh-rg \
# -n "connect-cluster-configs" \
# --namespace-name pagopa-d-itn-observ-gpd-evh \
# --cleanup-policy "Compact" \
# --status "Active" \
# --partition-count 1 \
# --retention-time 24

# ==============================================================
# logical topics
# ==============================================================

echo ">>>>>> 4"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_option" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

az eventhubs eventhub authorization-rule create \
--resource-group pagopa-d-itn-observ-evh-rg \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--eventhub-name cdc-raw-auto.apd.payment_option \
--name cdc-raw-auto.apd.payment_option-rx \
--rights Listen

echo ">>>>>> 5"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_position" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

az eventhubs eventhub authorization-rule create \
--resource-group pagopa-d-itn-observ-evh-rg \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--eventhub-name cdc-raw-auto.apd.payment_position \
--name cdc-raw-auto.apd.payment_position-rx \
--rights Listen

echo ">>>>>> 6"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.transfer" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24


az eventhubs eventhub authorization-rule create \
--resource-group pagopa-d-itn-observ-evh-rg \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--eventhub-name cdc-raw-auto.apd.transfer \
--name cdc-raw-auto.apd.transfer-rx \
--rights Listen
