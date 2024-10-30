#!/bin/bash
############################################################
# Terraform script for managing infrastructure on Azure
# Fingerprint: d2hhdHlvdXdhbnQ/Cg==
############################################################
# Global variables
# Version format x.y accepted
vers="1.11"
script_name=$(basename "$0")
git_repo="https://raw.githubusercontent.com/pagopa/eng-common-scripts/main/azure/${script_name}"
tmp_file="${script_name}.new"
# Check if the third parameter exists and is a file
if [ -n "$3" ] && [ -f "$3" ]; then
  FILE_ACTION=true
else
  FILE_ACTION=false
fi

# Define functions
function clean_environment() {
  rm -rf .terraform
  rm tfplan 2>/dev/null
  echo "cleaned!"
}

function download_tool() {
  #default value
  cpu_type="intel"
  os_type=$(uname)

  # only on MacOS
  if [ "$os_type" == "Darwin" ]; then
    cpu_brand=$(sysctl -n machdep.cpu.brand_string)
    if grep -q -i "intel" <<< "$cpu_brand"; then
      cpu_type="intel"
    else
      cpu_type="arm"
    fi
  fi

  echo $cpu_type
  tool=$1
  git_repo="https://raw.githubusercontent.com/pagopa/eng-common-scripts/main/golang/${tool}_${cpu_type}"
  if ! command -v $tool &> /dev/null; then
    if ! curl -sL "$git_repo" -o "$tool"; then
      echo "Error downloading ${tool}"
      return 1
    else
      chmod +x $tool
      echo "${tool} downloaded! Please note this tool WON'T be copied in your **/bin folder for safety reasons.
You need to do it yourself!"
      read -p "Press enter to continue"


    fi
  fi
}

function extract_resources() {
  TF_FILE=$1
  ENV=$2
  TARGETS=""

  # Check if the file exists
  if [ ! -f "$TF_FILE" ]; then
      echo "File $TF_FILE does not exist."
      exit 1
  fi

  # Check if the directory exists
  if [ ! -d "./env/$ENV" ]; then
      echo "Directory ./env/$ENV does not exist."
      exit 1
  fi

  TMP_FILE=$(mktemp)
  grep -E '^resource|^module' $TF_FILE > $TMP_FILE

  while read -r line ; do
      TYPE=$(echo $line | cut -d '"' -f 1 | tr -d ' ')
      if [ "$TYPE" == "module" ]; then
          NAME=$(echo $line | cut -d '"' -f 2)
          TARGETS+=" -target=\"$TYPE.$NAME\""
      else
          NAME1=$(echo $line | cut -d '"' -f 2)
          NAME2=$(echo $line | cut -d '"' -f 4)
          TARGETS+=" -target=\"$NAME1.$NAME2\""
      fi
  done < $TMP_FILE

  rm $TMP_FILE

  echo "./terraform.sh $action $ENV $TARGETS"
}

function help_usage() {
  echo "terraform.sh Version ${vers}"
  echo
  echo "Usage: ./script.sh [ACTION] [ENV] [OTHER OPTIONS]"
  echo "es. ACTION: init, apply, plan, etc."
  echo "es. ENV: dev, uat, prod, etc."
  echo
  echo "Available actions:"
  echo "  clean         Remove .terraform* folders and tfplan files"
  echo "  help          This help"
  echo "  list          List every environment available"
  echo "  update        Update this script if possible"
  echo "  summ          Generate summary of Terraform plan"
  echo "  tflist        Generate an improved output of terraform state list"
  echo "  tlock         Generate or update the dependency lock file"
  echo "  *             any terraform option"
}

function init_terraform() {
  if [ -n "$env" ]; then
    terraform init -reconfigure -backend-config="./env/$env/backend.tfvars"
  else
    echo "ERROR: no env configured!"
    exit 1
  fi
}

function list_env() {
  # Check if env directory exists
  if [ ! -d "./env" ]; then
    echo "No environment directory found"
    exit 1
  fi

  # List subdirectories under env directory
  env_list=$(ls -d ./env/*/ 2>/dev/null)

  # Check if there are any subdirectories
  if [ -z "$env_list" ]; then
    echo "No environments found"
    exit 1
  fi

  # Print the list of environments
  echo "Available environments:"
  for env in $env_list; do
    env_name=$(echo "$env" | sed 's#./env/##;s#/##')
    echo "- $env_name"
  done
}

function other_actions() {
  if [ -n "$env" ] && [ -n "$action" ]; then
    terraform "$action" -var-file="./env/$env/terraform.tfvars" -compact-warnings $other
  else
    echo "ERROR: no env or action configured!"
    exit 1
  fi
}

function state_output_taint_actions() {
  if [ "$action" == "tflist" ]; then
    # If 'tflist' is not installed globally and there is no 'tflist' file in the current directory,
    # attempt to download the 'tflist' tool
    if ! command -v tflist &> /dev/null && [ ! -f "tflist" ]; then
      download_tool "tflist"
      if [ $? -ne 0 ]; then
        echo "Error: Failed to download tflist!!"
        exit 1
      else
        echo "tflist downloaded!"
      fi
    fi
    if command -v tflist &> /dev/null; then
      terraform state list | tflist
    else
      terraform state list | ./tflist
    fi
  else
    terraform $action $other
  fi
}


function parse_tfplan_option() {
  # Create an array to contain arguments that do not start with '-tfplan='
  local other_args=()

  # Loop over all arguments
  for arg in "$@"; do
    # If the argument starts with '-tfplan=', extract the file name
    if [[ "$arg" =~ ^-tfplan= ]]; then
      echo "${arg#*=}"
    else
      # If the argument does not start with '-tfplan=', add it to the other_args array
      other_args+=("$arg")
    fi
  done

  # Print all arguments in other_args separated by spaces
  echo "${other_args[@]}"
}

function tfsummary() {
  local plan_file
  plan_file=$(parse_tfplan_option "$@")
  if [ -z "$plan_file" ]; then
    plan_file="tfplan"
  fi
  action="plan"
  other="-out=${plan_file}"
  other_actions
  if [ -n "$(command -v tf-summarize)" ]; then
    tf-summarize -tree "${plan_file}"
  else
    echo "tf-summarize is not installed"
  fi
  if [ "$plan_file" == "tfplan" ]; then
    rm $plan_file
  fi
}

function update_script() {
  # Check if the repository was cloned successfully
  if ! curl -sL "$git_repo" -o "$tmp_file"; then
    echo "Error cloning the repository"
    rm "$tmp_file" 2>/dev/null
    return 1
  fi

  # Check if a newer version exists
  remote_vers=$(sed -n '8s/vers="\(.*\)"/\1/p' "$tmp_file")
  if [ "$(printf '%s\n' "$vers" "$remote_vers" | sort -V | tail -n 1)" == "$vers" ]; then
    echo "The local script version is equal to or newer than the remote version."
    rm "$tmp_file" 2>/dev/null
    return 0
  fi

  # Check the fingerprint
  local_fingerprint=$(sed -n '4p' "$0")
  remote_fingerprint=$(sed -n '4p' "$tmp_file")

  if [ "$local_fingerprint" != "$remote_fingerprint" ]; then
    echo "The local and remote file fingerprints do not match."
    rm "$tmp_file" 2>/dev/null
    return 0
  fi

  # Show the current and available versions to the user
  echo "Current script version: $vers"
  echo "Available script version: $remote_vers"

  # Ask the user if they want to update the script
  read -rp "Do you want to update the script to version $remote_vers? (y/n): " answer

  if [ "$answer" == "y" ] || [ "$answer" == "Y" ]; then
    # Replace the local script with the updated version
    cp "$tmp_file" "$script_name"
    chmod +x "$script_name"
    rm "$tmp_file" 2>/dev/null

    echo "Script successfully updated to version $remote_vers"
  else
    echo "Update canceled by the user"
  fi

  rm "$tmp_file" 2>/dev/null
}

# Check arguments number
if [ "$#" -lt 1 ]; then
  help_usage
  exit 0
fi

# Parse arguments
action=$1
env=$2
filetf=$3
shift 2
other=$@

if [ -n "$env" ]; then
  # shellcheck source=/dev/null
  source "./env/$env/backend.ini"
  if [ -z "$(command -v az)" ]; then
    echo "az not found, cannot proceed"
    exit 1
  fi
  az account set -s "${subscription}"
fi

# Call appropriate function based on action
case $action in
  clean)
    clean_environment
    ;;
  ?|help|-h)
    help_usage
    ;;
  init)
    init_terraform "$other"
    ;;
  list)
    list_env
    ;;
  output|state|taint|tflist)
    init_terraform
    state_output_taint_actions $other
    ;;
  summ)
    init_terraform
    tfsummary "$other"
    ;;
  tlock)
    terraform providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=darwin_arm64 -platform=linux_amd64
    ;;
  update)
    update_script
    ;;
  *)
    if [ "$FILE_ACTION" = true ]; then
      extract_resources "$filetf" "$env"
    else
      init_terraform
      other_actions "$other"
    fi
    ;;
esac
