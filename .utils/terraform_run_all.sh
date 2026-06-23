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
