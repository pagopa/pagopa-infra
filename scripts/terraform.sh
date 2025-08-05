#!/bin/bash
############################################################
# Terraform script for managing infrastructure on Azure
# md5: 065397c756f4c6a1ba29f44d1e00ef74
############################################################
# Global variables
# Version format x.y accepted
vers="3.0"
script_name=$(basename "$0")
git_repo="https://raw.githubusercontent.com/pagopa/eng-common-scripts/main/azure/${script_name}"
tmp_file="${script_name}.new"
# Check if the third parameter exists and is a file
if [ -n "$3" ] && [ -f "$3" ]; then
  FILE_ACTION=true
else
  FILE_ACTION=false
fi

# Define colors and styles
# fixme find a way to color output on local and on devops agent, where tput returns an error
bold=""
normal=""
red=""
black=""
green=""
yellow=""
blue=""
magenta=""
cyan=""
white=""

os_type=$(uname)
 if [ "$os_type" == "Darwin" ]; then
    # Define colors and styles
    # fixme find a way to color output on local and on devops agent, where tput returns an error
    bold="$(tput bold)"
    normal="$(tput sgr0)"
    red="$(tput setaf 1)"
    black="$(tput setaf 0)"
    green="$(tput setaf 2)"
    yellow="$(tput setaf 3)"
    blue="$(tput setaf 4)"
    magenta="$(tput setaf 5)"
    cyan="$(tput setaf 6)"
    white="$(tput setaf 7)"
fi

# Define functions
function clean_environment() {
  rm -rf .terraform
  rm tfplan 2>/dev/null
  echo "cleaned!"
}



day() {
  date +"%Y-%m-%d"
}

hour() {
  date +"%H:%M:%S"
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

function audit_pre_apply() {
  file_name=$1
  partition_key=$2
  row_key=$3
  skip_policy=$4

  # load audit config
  source "$root_folder/.terraform-audit"
  # save plan to readable file
  terraform show -no-color "$file_name.tfplan" > "$file_name.plan"

  branch_name=$(git rev-parse --abbrev-ref HEAD)
  commit_hash=$(git rev-parse HEAD)
  git_project=$(git remote get-url origin)
  # get the current apply folder
  root_folder_length=${#root_folder}
  root_folder_index=$((root_folder_length + 1))
  current_folder=$(pwd | cut -c $root_folder_index- )
  # azure user applying the changes
  current_user=$(az ad signed-in-user show --query userPrincipalName -o tsv)

  echo "Auditing apply operation..."
  # save apply parameters to audit table
  entity_insert=$(az storage entity insert --account-name "$audit_storage_account_name" \
    --table-name "$audit_table_name" \
    --auth-mode key \
    --only-show-errors \
    --entity PartitionKey="$partition_key" RowKey="$row_key" BranchName="$branch_name" CommitHash="$commit_hash" SkipPolicy="$skip_policy" SkipPolicy@odata.type=Edm.Boolean Watched="false" Watched@odata.type=Edm.Boolean PlanFile="$file_name.plan" ApplyFile="$file_name.apply" Arguments="$other" User="$current_user" Folder="$current_folder" Project="$git_project")
  # save plan to audit container
  plan_upload=$(az storage blob upload --account-name "$audit_storage_account_name" \
  --container-name "$audit_container_name" \
  --auth-mode key \
  --only-show-errors \
  --file "$file_name.plan" \
  --name "$file_name.plan" \
  --overwrite true)
}

function audit_post_apply() {
  file_name=$1
  partition_key=$2
  row_key=$3

  # load audit config
  source "$root_folder/.terraform-audit"

  apply_success=$(grep -c "Apply complete!" "$file_name.apply")
  echo "Apply completed, auditing apply result..."
  # save apply result to audit container
  entity_update=$(az storage entity merge --account-name "$audit_storage_account_name" \
    --table-name "$audit_table_name" \
    --auth-mode key \
    --only-show-errors \
    --entity PartitionKey="$partition_key" RowKey="$row_key" ApplySuccess="$([ "$apply_success" = 1 ] && echo "true" || echo "false")" ApplySuccess@odata.type=Edm.Boolean )

  apply_upload=$(az storage blob upload --account-name "$audit_storage_account_name" \
  --container-name "$audit_container_name" \
  --file "$file_name.apply" \
  --name "$file_name.apply" \
  --auth-mode key \
  --only-show-errors \
  --overwrite true)
}

function check_arguments() {
  # avoid auto approve in prod environment
  if [[ "$other" == *"-auto-approve"* ]]; then
    echo "${red}${bold}ERROR: -auto-approve parameter not allowed in prod environment!${normal}"
    exit 1
  fi
  # avoid -out parameter, used internally to save the plan file for auditing purposes
  if [[ "$other" == *"-out="* ]]; then
    echo "${red}${bold}ERROR: -out parameter not allowed in prod apply. Already used for auditing purposes!${normal}"
    exit 1
  fi
}

function check_plan_output(){
  plan_exitcode=$1
  # check if changes are present
  if [ "$plan_exitcode" == 0 ]; then
    echo "${bold}No changes to apply!${normal}"
    rm "$file_name.tfplan" 2>/dev/null
    exit 0
  fi
  if [ "$plan_exitcode" == 1 ]; then
    rm "$file_name.tfplan" 2>/dev/null
    exit 1
  fi
}

function check_conftest_output(){
  opa_global_exitcode=$1
  # check if changes are present
  if [ $opa_global_exitcode == 0 ]; then
    echo "${bold}${blue}OPEN Policy Test SUCCESS!${normal}"
  fi
  if [ $opa_global_exitcode -gt 0 ]; then
    echo "${bold}${red}OPEN Policy Test FAILURE!${black}${normal}"
    read -p "${bold}${red}Are you sure to continue? (only yes will be accepted): ${normal}" skip_confirmation
    if [ "$skip_confirmation" != "yes" ]; then
        clean_audit_files  "$file_name"
        exit 1
    else
        skip_policy="true"
    fi


  fi
}

function clean_audit_files() {
  file_name=$1
  # cleanup temporary files
  rm "$file_name.plan" 2>/dev/null
  rm "$file_name.apply" 2>/dev/null
  rm "$file_name.tfplan" 2>/dev/null
  rm "$file_name.json" 2>/dev/null
  rm "$file_name.jq" 2>/dev/null
}

function opa_check_policy() {

        # load opa config
        if ! command -v opa &> /dev/null && [ ! -f "opa" ]; then
          brew install opa --quiet
          if [ $? -ne 0 ]; then
            echo "${red}Error: Failed to install opa!!"
            exit 1
          else
            echo "Install opa ${green}SUCCESS!"
          fi
        fi

        source "$root_folder/.terraform-opa"

        terraform show -json "$file_name.tfplan" > "$file_name.json"

        # checkout opa policies
        git clone -c advice.detachedHead=false --branch "$opa_policy_version" https://github.com/pagopa/opa-policy.git  "$root_folder/$opa_policy_clone_folder" --quiet

        # calcolo score
        score=$(opa eval --data "$root_folder/$opa_policy_folder/global/opa.terraform/apply_score.rego" --input "$file_name.json" "data.pagopa.score.opa.terraform.plan.apply_score.score" --format pretty)
        authz=$(opa eval --data "$root_folder/$opa_policy_folder/global/opa.terraform/apply_score.rego" --input "$file_name.json" "data.pagopa.score.opa.terraform.plan.apply_score.authz" --format pretty)
        if [ "$authz" != "true" ]; then
          scorecolor="${red}"
        else
          scorecolor="${green}"
        fi
        read -p "${bold}Apply Score: ${scorecolor}${score}${normal} Continue (only yes will be accepted): ${normal}" score_confirmation

        if [ "$score_confirmation" != "yes" ]; then
          clean_audit_files  "$file_name"
          exit 1
        fi

        #policy evaluation
        opa eval --data $root_folder/$opa_policy_folder --input "$file_name.json" "data.azure.global.opa" --format values --fail-defined > $file_name.jq
        opa_exitcode=$?
        opa eval --data $root_folder/$opa_policy_folder --input "$file_name.json" "data.azure.$opa_service_tag.opa" --format values --fail-defined >> $file_name.jq
        opa_custom_exitcode=$?

        opa_global_exitcode=$((opa_exitcode+opa_custom_exitcode))

        rm -rf "$root_folder/$opa_policy_clone_folder" 2>/dev/null
        if [ $opa_global_exitcode -gt 0 ]; then
          cat $file_name.jq | jq -r '..|.deny? | select(. != null) '| jq -r ' ( .[])| @tsv' | awk -v FS="|" 'BEGIN{print ""}{printf "%s\t%s\n","\033[33m"$1,"\033[31m"$2}'
          check_conftest_output "$opa_global_exitcode"
        fi

}


function other_actions() {
  if [ -n "$env" ] && [ -n "$action" ]; then
    root_folder=$(git rev-parse --show-toplevel)
    # if apply in prod environment and audit settings are defined
    if [ "$action" == "apply" ] && [[ "$env" == *"dev" ]] && [ -f "$root_folder/.terraform-audit" ]; then

      check_arguments
      # skip_policy to false by default
      skip_policy="false"
      # parameters for audit
      uuid=$(uuidgen)
      # unique record keys
      partition_key=$(day)
      row_key="$(hour)_$uuid"
      # plan and apply file name
      file_name="$partition_key-$row_key"

      # plan to file
      terraform plan -var-file="./env/$env/terraform.tfvars" -compact-warnings -out="$file_name.tfplan" -detailed-exitcode $other
      plan_exitcode=$?
      check_plan_output "$plan_exitcode"

      echo ""

      if [ -f "$root_folder/.terraform-opa" ]
      then

        opa_check_policy

      fi


      # ask user confirmation before applying changes
      read -p "${bold}Apply these changes (only yes will be accepted): ${normal}" apply_confirmation
      if [ "$apply_confirmation" == "yes" ]; then
        audit_pre_apply "$file_name" "$partition_key" "$row_key" "$skip_policy"
        terraform apply -auto-approve "$file_name.tfplan" -compact-warnings | tee "$file_name.apply"
        audit_post_apply "$file_name" "$partition_key" "$row_key"
        # cleanup temporary files
        clean_audit_files "$file_name"
      else
        echo "${bold}Apply canceled${normal}"
      fi
      # clean plan file
      clean_audit_files "$file_name"
    else
      terraform "$action" -var-file="./env/$env/terraform.tfvars" -compact-warnings $other
    fi


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
  export ARM_SUBSCRIPTION_ID=$(az account list --query "[?isDefault].id" --output tsv)
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
