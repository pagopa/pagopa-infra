#!/usr/bin/env bash
set -e
############################################################
# Setup configuration relative to a given subscription
# Subscription are defined in ./subscription
# Fingerprint: c2V0dXAuc2gK
############################################################
# Global variables
VERS="1.1"
# Gestisce le diverse posizioni di "ENV"
THISENV=$(ls -d ./env 2>/dev/null || ls -d ../env 2>/dev/null)

# Define a helper function to print usage information                                                     #
function print_usage() {
  echo "Setup v."${VERS} "sets up a configuration relative to a specific subscription"
  echo "Usage: cd <scripts folder>"
  echo "  ./setup.sh <ENV>"
  for thisenv in $(ls $THISENV)
  do
      echo "  Example: ./setup.sh ${thisenv}"
  done
  echo
  echo "Syntax: setup.sh [-l|h|k]"
  echo "  options:"
  echo "  h     Print this Help."
  echo "  l     List available environments."
  echo "  k     Kubelogin convert kubeconfig."
  echo
}

# Define variables                                         
function def_var() {
  # Check if Azure CLI is installed
  ENV=$1
  if ! command -v az &> /dev/null; then
    installpkg "azure-cli"
  fi

  export aks_name_from_cli=$(az aks list -o tsv --query "[?contains(name,'$ENV-aks')].{Name:name}" 2>/dev/null | tr -d '\r')
  export aks_name=${aks_name_from_cli}
  echo "[INFO] aks_name_from_cli: ${aks_name_from_cli}"
  export aks_resource_group_name_from_cli=$(az aks list -o tsv --query "[?contains(name,'$ENV-aks')].{Name:resourceGroup}" 2>/dev/null)
  echo "[INFO] aks_resource_group_name_from_cli: ${aks_resource_group_name_from_cli}"

  # ⚠️ in windows, even if using cygwin, these variables will contain a landing \r character
  export aks_name=${aks_name_from_cli//[$'\r']}
  # echo "[INFO] aks_name: ${aks_name}"
  export aks_resource_group_name=${aks_resource_group_name_from_cli//[$'\r']}
  # echo "[INFO] aks_resource_group_name: ${aks_resource_group_name}"

# if using cygwin, we have to transcode the WORKDIR
export HOME_DIR=$HOME
if [[ $HOME_DIR == /cygdrive/* ]]; then
  export HOME_DIR=$(cygpath -w ~)
  export HOME_DIR=${HOME_DIR//\\//}
fi
}


# TBD: Check if there is a newer script version                 
# function check_update() {
#   # Check for a newer version of the script on a remote location, such as a website or a repository
#   new_script_location="$(cat ${config_file}  | grep script_url | awk -F": " '{print $2}' | awk -F"\"" '{print $2}')"

#   # Download the new script and overwrite the old one
#   if curl --fail --silent --location "$new_script_location" > "$current_script_location"; then
#     chmod +x "$current_script_location"
#     echo "Successfully updated the script $current_script_name"
#     exit 0
#   else
#     echo "No update found for the script $current_script_name"
#   fi

#   # check if we can download the remote script
#   curl -s "$new_script_location" > remote_script.sh || {
#     echo "Error: Unable to download the remote script."
#     return 1
#   }

#   # compare the local and remote script version
#   local_version=$(cat "version: " | grep "version: " | awk '{print $2}' | tr -d "\"")
#   remote_version=$(grep -oP '# version \K[^\s]+' remote_script.sh)

#   if [ "$local_version" = "$remote_version" ]; then
#     echo "You are already using the latest version ($local_version) of the script."
#     rm remote_script.sh
#     return 0
#   fi

#   # overwrite the local script with the remote version
#   mv remote_script.sh script.sh
#   echo "Successfully updated to version $remote_version."
#   return 0
# }

# Check chosen environment                                 
function check_env() {
  ENV=$1

  # Check if backend.ini exists
  if [ -f "${THISENV}/${ENV}/backend.ini" ]; then
    source "${THISENV}/${ENV}/backend.ini"
  else
    echo "[ERROR] File ${THISENV}/$ENV/backend.ini not found."
    exit 1
  fi
  # Check if subscription has been specified
  if [ -z "${subscription}" ]; then
    echo "[ERROR] Subscription not found in the environment file: ${env_file_path}"
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

function installpkg() {
  if [ -z "$1" ]; then
    echo "Impossible to proceed"
    return 1
  fi
  pkg=$1
  # Check if the kubelogin command exists
  if ! command -v $pkg &> /dev/null; then
      echo "The ${pkg} command is not present on the system."

      # Ask the user for confirmation to install kubelogin
      read -p "Do you want to install ${pkg} using brew? (Y/n): " response
      if [ "$response" = "y" ] || [ "$response" = "Y" ]; then
          echo "Installing ${pkg} using brew..."
          brew install ${pkg}

          if [ $? -eq 0 ]; then
              echo "${pkg} successfully installed."
          else
              echo "An error occurred during the installation of ${pkg}. Check the output for more information."
              return 1
          fi
      else
          echo "${pkg} installation canceled by the user."
          exit 1
      fi
  fi
}
function setup() {
  # Main part. It set aks credentials
  if ! command -v kubectl &> /dev/null; then
    installpkg "kubectl"
  fi
  rm -rf "${HOME}/.kube/config-${aks_name}"
  az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${subscription}" --file "~/.kube/config-${aks_name}"
  az aks get-credentials -g "${aks_resource_group_name}" -n "${aks_name}" --subscription "${subscription}" --overwrite-existing

  # with AAD auth enabled we need to authenticate the machine on the first setup
  echo "Follow Microsoft sign in steps. kubectl get namespaces command will fail but it's the expected behavior"
  kubectl --kubeconfig="${HOME_DIR}/.kube/config-${aks_name}" get namespaces
  kubectl config use-context "${aks_name}"
  kubectl get namespaces
}

# Main program                                             
while getopts ":hlk-:" option; do
   case $option in
      h) # display Help
        print_usage
        exit;;
      l) # list available environments
        echo "Available environment(-s):"
        ls -1 $THISENV
        exit;;
      k) # kubelogin convert kubeconfig
        echo "converting kubeconfig to use azurecli login mode."
        installpkg "kubelogin"
	for n in $(ls -1 /Users/$(whoami)/.kube/config*); do
          kubelogin convert-kubeconfig -l azurecli --kubeconfig $n
	done
         exit;;
      *) # Invalid option
        echo "Error: Invalid option"
        exit;;
   esac
done

if [[ $1 ]]; then
  check_env $1
  def_var $1
  setup
else
  print_usage
fi
