#!/bin/bash

set -e

# ==============================================================
# config topics
# ==============================================================

env=$1

if [ "$env" != "p" ]; then
    partitioncount=1
    retentiontime=24 #hh = 1day
else
    partitioncount=32
    retentiontime=168 #hh = 1week
fi

echo "partitioncount >> ${partitioncount}"
echo "retentiontime  >> ${retentiontime}"


echo ">>>>>> 1"

# org.apache.kafka.common.config.ConfigException: Topic 'connect-cluster-configs' supplied via the 'config.storage.topic' property is required to have a single partition in order to guarantee consistency of connector configurations

az eventhubs eventhub create \
-g pagopa-$env-itn-observ-evh-rg \
-n "connect-cluster-offsets" \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time ${retentiontime}

echo ">>>>>> 2"

az eventhubs eventhub create \
-g pagopa-$env-itn-observ-evh-rg \
-n "connect-cluster-status" \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time ${retentiontime}

echo ">>>>>> 3"

az eventhubs eventhub create \
-g pagopa-$env-itn-observ-evh-rg \
-n "connect-cluster-configs" \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count 1 \
--retention-time ${retentiontime}

# ==============================================================
# logical topics
# ==============================================================

echo ">>>>>> 4"

az eventhubs eventhub create \
-g pagopa-$env-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_option" \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count ${partitioncount} \
--retention-time ${retentiontime}

# created by @aferracci tnx2 MS https://github.com/Azure/azure-cli/issues/30419
az eventhubs eventhub authorization-rule create \
--resource-group pagopa-$env-itn-observ-evh-rg \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--eventhub-name cdc-raw-auto.apd.payment_option \
--name cdc-raw-auto.apd.payment_option-rx \
--rights Listen

echo ">>>>>> 5"

az eventhubs eventhub create \
-g pagopa-$env-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.payment_position" \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count ${partitioncount} \
--retention-time ${retentiontime}

az eventhubs eventhub authorization-rule create \
--resource-group pagopa-$env-itn-observ-evh-rg \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--eventhub-name cdc-raw-auto.apd.payment_position \
--name cdc-raw-auto.apd.payment_position-rx \
--rights Listen

echo ">>>>>> 6"

az eventhubs eventhub create \
-g pagopa-$env-itn-observ-evh-rg \
-n "cdc-raw-auto.apd.transfer" \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--cleanup-policy "Compact" \
--status "Active" \
--partition-count ${partitioncount} \
--retention-time ${retentiontime}


az eventhubs eventhub authorization-rule create \
--resource-group pagopa-$env-itn-observ-evh-rg \
--namespace-name pagopa-$env-itn-observ-gpd-evh \
--eventhub-name cdc-raw-auto.apd.transfer \
--name cdc-raw-auto.apd.transfer-rx \
--rights Listen
