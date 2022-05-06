#!/usr/bin/env bash
set -e

#
# Setup configuration relative to a given subscription
# Subscription are defined in ./subscription
# Usage:
#  ./setup.sh <ENV>
#
#  ./setup.sh dev
#  ./setup.sh uat
#  ./setup.sh prod

SCRIPT_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CURRENT_DIRECTORY="$(basename "$SCRIPT_PATH")"
ENV=$1
# must be subscription in lower case
subscription=""

#
# 🏁 start shell init
#
if [ -z "$ENV" ]; then
  echo "[ERROR] You must set an ENV parameter"
  exit 0
fi

if [ ! -d "../env/$ENV" ]; then
  echo "[ERROR] ENV should be one of:"
  ls "../env"
  exit 0
fi

# shellcheck source=/dev/null
source "../env/$ENV/backend.ini"

if [ -z "${subscription}" ]; then
    printf "[ERROR] \e[1;31mYou must provide a subscription.\n"
    exit 1
fi

echo "[INFO] This is the current directory: ${CURRENT_DIRECTORY}"

echo "[INFO] Subscription: ${subscription}"
az account set -s "${subscription}"

#
# LOAD VARIABLES
#
aks_name_from_cli=$(az aks list -o tsv --query "[?contains(name,'$ENV-aks')].{Name:name}")
echo "[INFO] aks_name_from_cli: ${aks_name_from_cli}"
aks_resource_group_name_from_cli=$(az aks list -o tsv --query "[?contains(name,'$ENV-aks')].{Name:resourceGroup}")
echo "[INFO] aks_resource_group_name_from_cli: ${aks_resource_group_name_from_cli}"

# ⚠️ in widows, even if using cygwin, these variables will contain a landing \r character
aks_name=${aks_name_from_cli//[$'\r']}
echo "[INFO] aks_name: ${aks_name}"
aks_resource_group_name=${aks_resource_group_name_from_cli//[$'\r']}
echo "[INFO] aks_resource_group_name: ${aks_resource_group_name}"

# if using cygwin, we have to transcode the WORKDIR
HOME_DIR=$HOME
if [[ $HOME_DIR == /cygdrive/* ]]; then
  HOME_DIR=$(cygpath -w ~)
  HOME_DIR=${HOME_DIR//\\//}
fi

#
# 🖥 start script
#
rm -rf "${HOME}/.kube/config-${aks_name}"
az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${subscription}" --file "~/.kube/config-${aks_name}"
az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${subscription}" --overwrite-existing

# with AAD auth enabled we need to authenticate the machine on the first setup
echo "Follow Microsoft sign in steps. kubectl get pods command will fail but it's the expected behavior"
kubectl --kubeconfig="${HOME_DIR}/.kube/config-${aks_name}" get pods
kubectl config use-context "${aks_name}"
kubectl get pods
