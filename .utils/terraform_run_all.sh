#!/bin/bash



#
# bash .utils/terraform_run_all.sh <Action>
# bash .utils/terraform_run_all.sh init
#

# 'set -e' tells the shell to exit if any of the foreground command fails,
# i.e. exits with a non-zero status.
set -eu

pids=()
ACTION="$1"

array=(
    'src/aks-leonardo::itn-dev'
    'src/aks-platform::weu-dev'
    'src/core::dev'
    'src/grafana-monitoring::weu-dev'
    'src/next-aks::weu-dev'
    'src/next-core::dev'
    'src/network::dev'
    'src/network-secrets::dev'
    'src/tf-audit::weu-prod'
    'src/packer::dev'
    'src/synthetic-monitoring::weu-dev'
    'src/zabbix::dev'
    'src/domains/aca-app::weu-dev'
    'src/domains/aca-common::weu-dev'
    'src/domains/afm-app::weu-dev'
    'src/domains/afm-common::weu-dev'
    'src/domains/apiconfig-app::weu-dev'
    'src/domains/apiconfig-common::weu-dev'
    'src/domains/bizevents-app::weu-dev'
    'src/domains/bizevents-common::weu-dev'
    'src/domains/canoneunico::weu-dev'
    'src/domains/checkout-app::weu-dev'
    'src/domains/checkout-common::weu-dev'
    'src/domains/ecommerce-app::weu-dev'
    'src/domains/ecommerce-common::weu-dev'
    'src/domains/fdr-app::weu-dev'
    'src/domains/fdr-common::weu-dev'
    'src/domains/fdr-secret::weu-dev'
    'src/domains/gps-app::weu-dev'
    'src/domains/gps-common::weu-dev'
    'src/domains/load-test::weu-dev'
    'src/domains/mock-app::weu-dev'
    'src/domains/mock-common::weu-dev'
    'src/domains/nodo-app::weu-dev'
    'src/domains/nodo-common::weu-dev'
    'src/domains/nodo-cron::weu-dev'
    'src/domains/nodo-secret::weu-dev'
    'src/domains/nodo-switcher::weu-dev'
    'src/domains/observability::weu-dev'
    'src/domains/pay-wallet-app::itn-dev'
    'src/domains/pay-wallet-common::itn-dev'
    'src/domains/printit-app::itn-dev'
    'src/domains/printit-common::itn-dev'
    'src/domains/printit-legacy::itn-dev'
    'src/domains/printit-secrets::itn-dev'
    'src/domains/qi-app::weu-dev'
    'src/domains/qi-common::weu-dev'
    'src/domains/qi-secrets::weu-dev'
    'src/domains/receipts-app::weu-dev'
    'src/domains/receipts-common::weu-dev'
    'src/domains/receipts-secrets::weu-dev'
    'src/domains/selfcare-app::weu-dev'
    'src/domains/selfcare-common::weu-dev'
    'src/domains/shared-app::weu-dev'
    'src/domains/shared-common::weu-dev'
    'src/domains/wallet-app::weu-dev'
    'src/domains/wallet-common::weu-dev'
)

function rm_terraform {
    find . \( -iname ".terraform*" ! -iname ".terraform-docs*" ! -iname ".terraform-version" ! -iname ".terraform.lock.hcl" \) -print0 | xargs -0 rm -rf
}

# echo "[INFO] 🪚  Delete all .terraform folders"
# rm_terraform

echo "[INFO] 🏁 Init all terraform repos"
for index in "${array[@]}" ; do
    FOLDER="${index%%::*}"
    COMMAND="${index##*::}"
    pushd "$(pwd)/${FOLDER}"
        echo "$FOLDER - $COMMAND"
        echo "🔬 folder: $(pwd) in under terraform: $ACTION action"

        sh terraform.sh "$ACTION" "$COMMAND"
        # pids+=($!)
    popd
done


# Wait for each specific process to terminate.
# Instead of this loop, a single call to 'wait' would wait for all the jobs
# to terminate, but it would not give us their exit status.
#
# for pid in "${pids[@]}"; do
#   #
#   # Waiting on a specific PID makes the wait command return with the exit
#   # status of that process. Because of the 'set -e' setting, any exit status
#   # other than zero causes the current shell to terminate with that exit
#   # status as well.
#   #
#   wait "$pid"
# done
