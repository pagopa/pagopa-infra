#!/usr/bin/env bash
set -e
############################################################
# Setup configuration relative to a given subscription
# Subscription are defined in ./subscription
# Fingerprint: c2V0dXAuc2gK
############################################################

############################################################
# Execute ./k8setup.sh for instructions
############################################################

# Global variables
VERS="1.2"
# Gestisce le diverse posizioni di "ENV"
THISENV=$(ls -d ./env 2>/dev/null || ls -d ../env 2>/dev/null)

# Define a helper function to print usage information                                                     #
function print_usage() {
  echo "Setup v."${VERS} "sets up a configuration relative to a specific subscription"
  echo "-------------------------------------------------------------------------"
  echo "Requirements (automatically installed): kubectl, kubelogin, azure-cli, jq"
  echo "-------------------------------------------------------------------------"
  echo "Usage: cd <scripts folder>"
  echo "  ./k8setup.sh <ENV>"
  for thisenv in ${THISENV}
  do
      echo "  Example: ./k8setup.sh ${thisenv}"
  done
  echo
  echo "Syntax: setup.sh [-l|h|k|s]"
  echo "  options:"
  echo "  h     Print this Help."
  echo "  k     Kubelogin convert kubeconfig."
  echo "  l     List available environments."
  echo "  s     Install requirements."
  echo
}

# Define variables
function def_var() {
  # Check if Azure CLI is installed
  ENV=$1
  if ! command -v az &> /dev/null; then
    installpkg "azure-cli"
  fi

  aks_name_from_cli=$(az aks list -o tsv --query "[?contains(name,'$ENV-aks')].{Name:name}" 2>/dev/null | tr -d '\r')
  aks_name=${aks_name_from_cli}
  echo "[INFO] aks_name_from_cli: ${aks_name_from_cli}"
  aks_resource_group_name_from_cli=$(az aks list -o tsv --query "[?contains(name,'$ENV-aks')].{Name:resourceGroup}" 2>/dev/null)
  echo "[INFO] aks_resource_group_name_from_cli: ${aks_resource_group_name_from_cli}"

  # ⚠️ in windows, even if using cygwin, these variables will contain a landing \r character
  aks_name=${aks_name_from_cli//[$'\r']}
  # echo "[INFO] aks_name: ${aks_name}"
  aks_resource_group_name=${aks_resource_group_name_from_cli//[$'\r']}
  # echo "[INFO] aks_resource_group_name: ${aks_resource_group_name}"

  # if using cygwin, we have to transcode the WORKDIR
  export HOME_DIR=$HOME
  if [[ $HOME_DIR == /cygdrive/* ]]; then
    home_dir=$(cygpath -w ~)
    export HOME_DIR=$home_dir
    export HOME_DIR=${HOME_DIR//\\//}
  fi
}


# Check chosen environment
function check_env() {
  ENV=$1

  # Check if env has been properly entered
  if [ ! -d "${THISENV}/$ENV" ]; then
    echo "[ERROR] ENV should be one of:"
    ls -1 ${THISENV}
    exit 1
  fi

  env_file_path="${THISENV}/${ENV}/backend.ini"

  # Check if backend.ini exists
  if [ -f "$env_file_path" ]; then
    #shellcheck source=../env/dev01/backend.ini
    source "$env_file_path"
  else
    echo "[ERROR] File $env_file_path not found."
    exit 1
  fi

  # Check if subscription has been specified
  if [ -z "${subscription}" ]; then
    echo "[ERROR] Subscription not found in the environment file: '$env_file_path'}"
    exit 1
  fi

  # Show the current directory
  SCRIPT_PATH="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
  CURRENT_DIRECTORY="$(basename "$SCRIPT_PATH")"
  echo "[INFO] This is the current directory: ${CURRENT_DIRECTORY}"

  echo "[INFO] Subscription: ${subscription}"
  if ! command -v az &> /dev/null; then
    installpkg "azure-cli"
  fi
  az account set -s "${subscription}"
}

# installs a package if not already installed
# parameters:
# $1: name of the package
# $2: optional, executable command for $1 package. defaults to $1
function installpkg() {
  if [ -z "$1" ]; then
    echo "Impossible to proceed"
    return 1
  fi

  pkg=$1
  if [ -z "$2" ]
    then
      cmd=$pkg
    else
      cmd=$2
  fi

  # Check if the <package> command exists
  if ! command -v "${cmd}" &> /dev/null; then
      echo "The ${pkg} command is not present on the system."

      # Ask the user for confirmation to install the package
      read -p "Do you want to install ${pkg} using brew? (Y/n): " response
      if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
          echo "Installing ${pkg} using brew..."
          if brew install "${pkg}" ; then
              echo "${pkg} successfully installed."
          else
              echo "An error occurred during the installation of ${pkg}. Check the output for more information."
              return 1
          fi
      else
          echo "${pkg} installation canceled by the user."
          exit 1
      fi
      else
        echo "${pkg} already installed"
  fi
}
function setup() {
  # Main part. It set aks credentials
  if ! command -v kubectl &> /dev/null; then
    installpkg "kubectl"
  fi
  rm -rf "${HOME}/.kube/config-${aks_name}"

  if ! command -v jq &> /dev/null; then
      installpkg "jq"
  fi

  # check if aks cluster is running
  AKS_STATUS=$(az aks show --name "${aks_name}" --resource-group "${aks_resource_group_name}" | jq -r .provisioningState)
  echo "AKS custer status is: '${AKS_STATUS}'"
  if [ ! "${AKS_STATUS}" = "Succeeded" ]
  then
    echo "AKS cluster is not running. Terminating..."
    exit 1
  fi

  az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${subscription}" --file "${HOME_DIR}/.kube/config-${aks_name}"
  # verify connection with k8s cluster
  echo "Checking connection to AKS cluster ${aks_name}"
  kubectl --kubeconfig="${HOME_DIR}/.kube/config-${aks_name}" get namespaces

  # merge cluster configuration into global configuration
  az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${subscription}" --overwrite-existing

  # with AAD auth enabled we need to authenticate the machine on the first setup
  echo "Follow Microsoft sign in steps. kubectl get namespaces command may fail but it's the expected behavior"
  kubectl config use-context "${aks_name}"
  kubectl get namespaces

  # convert configuration format
  for confg in /Users/"$(whoami)"/.kube/config*; do
    kubelogin convert-kubeconfig -l azurecli --kubeconfig "$confg"
  done
}

# Main program
while getopts ":hlks-:" option; do
   case $option in
      h) # display Help
        print_usage
        exit;;
      k) # kubelogin convert kubeconfig
        echo "converting kubeconfig to use azurecli login mode."
        installpkg "kubelogin"
        for confg in /Users/"$(whoami)"/.kube/config*; do
          kubelogin convert-kubeconfig -l azurecli --kubeconfig "$confg"
          echo "${confg} converted!"
        done
        exit;;
      l) # list available environments
        echo "Available environment(-s):"
        ls -1 "$THISENV"
        exit;;
      s) #setup requirements
        echo "Installing requirements..."
        installpkg "azure-cli" "az"
        installpkg "kubectl"
        installpkg "kubelogin"
        installpkg "jq"
        for confg in /Users/"$(whoami)"/.kube/config*; do
          kubelogin convert-kubeconfig -l azurecli --kubeconfig "$confg"
          echo "${confg} converted!"
        done
        exit;;
      *) # Invalid option
        echo "Error: Invalid option"
        echo ""
        echo ""
        print_usage
        exit;;
   esac
done

if [[ $1 ]]; then
  check_env "$1"
  def_var "$1"
  setup
else
  print_usage
fi
