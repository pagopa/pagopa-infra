#!/bin/sh
set -e

BASE_URL="https://weudev.gps.internal.dev.platform.pagopa.it/gpd-rtp-service"
if [ "$CLOUDO_ENVIRONMENT" = "uat" ]; then
  BASE_URL="https://weuuat.gps.internal.uat.platform.pagopa.it/gpd-rtp-service"
elif [ "$CLOUDO_ENVIRONMENT" = "prod" ]; then
  BASE_URL="https://weuprod.gps.internal.platform.pagopa.it/gpd-rtp-service"
fi

# Send retry request for all dead letter messages with default minutes offset of 2 (ignore messages newer than 2 minutes)
curl -sS -X POST \
  -H "Content-Type: application/json" \
  -d "$RESPONSE" \
  "${BASE_URL}/error-messages/retry/all"