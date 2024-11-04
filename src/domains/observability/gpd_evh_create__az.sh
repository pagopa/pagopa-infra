#!/bin/bash

set -e

# ==============================================================
# config topics
# ==============================================================


echo ">>>>>> 1"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "connect-cluster-offsets" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

echo ">>>>>> 2"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "connect-cluster-status" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

echo ">>>>>> 3"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "connect-cluster-configs" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

# ==============================================================
# logical topics
# ==============================================================

echo ">>>>>> 4"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "azcligpd-ingestion.apd.payment_option" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

echo ">>>>>> 4"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "azcligpd-ingestion.apd.payment_option_metadata" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

echo ">>>>>> 5"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "azcligpd-ingestion.apd.payment_position" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

echo ">>>>>> 6"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "azcligpd-ingestion.apd.transfer" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24

echo ">>>>>> 7"

az eventhubs eventhub create \
-g pagopa-d-itn-observ-evh-rg \
-n "azcligpd-ingestion.apd.transfer_metadata" \
--namespace-name pagopa-d-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time 24
