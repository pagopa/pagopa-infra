#!/usr/bin/env bash
set -euo pipefail

# ----------------------------------------------------------------------
# Colori
# ----------------------------------------------------------------------
bold="$(tput bold 2>/dev/null || echo '')"
normal="$(tput sgr0 2>/dev/null || echo '')"
red="$(tput setaf 1 2>/dev/null || echo '')"
green="$(tput setaf 2 2>/dev/null || echo '')"
blue="$(tput setaf 4 2>/dev/null || echo '')"
yellow="$(tput setaf 3 2>/dev/null || echo '')"

# ----------------------------------------------------------------------
# Validazione argomenti
# ----------------------------------------------------------------------
if [ "$#" -ne 3 ]; then
    echo "${bold}Rimozione Risorse dallo Stato Terraform${normal}"
    echo "====================================================================="
    echo "${yellow}Uso:${normal} $0 <ENV> <CARTELLA> <NOME_FILE.tf>"
    echo "${yellow}Esempio:${normal} $0 dev ./vecchio-progetto donations.tf"
    echo "====================================================================="
    exit 1
fi

ENV_A="$1"
DIR_A="$2"
FILENAME="$3"
FILE_PATH="$DIR_A/$FILENAME"
START_DIR=$(pwd)

if [ ! -f "$FILE_PATH" ]; then
    echo "${red}${bold}ERRORE:${normal}${red} Il file '$FILE_PATH' non esiste.${normal}"
    exit 1
fi

# ----------------------------------------------------------------------
# Funzione per simulare l'inizializzazione del tuo terraform.sh
# ----------------------------------------------------------------------
function init_environment() {
    local target_dir=$1
    local target_env=$2

    echo "${blue}>>> Inizializzazione ambiente '${target_env}' in ${target_dir}...${normal}"

    cd "$target_dir" || { echo "${red}Impossibile accedere a $target_dir${normal}"; exit 1; }

    # Set della subscription usando il tuo pattern backend.ini
    if [ -f "./env/$target_env/backend.ini" ]; then
        source "./env/$target_env/backend.ini"
        if [ -z "$(command -v az)" ]; then
            echo "${red}az cli non trovato!${normal}"
            exit 1
        fi
        az account set -s "${subscription}" > /dev/null
        export ARM_SUBSCRIPTION_ID=$(az account list --query "[?isDefault].id" --output tsv)
    else
        echo "${yellow}ATTENZIONE: ./env/$target_env/backend.ini non trovato. Salto az account set.${normal}"
    fi

    # Inizializzazione Terraform
    terraform init -reconfigure -backend-config="./env/$target_env/backend.tfvars" > /dev/null

    cd "$START_DIR"
}

# ======================================================================
# INIZIO PROCESSO
# ======================================================================

echo "${bold}1. Analisi del file '$FILENAME' per identificare le risorse...${normal}"
BASES_RESOURCE=$(grep -E '^[[:space:]]*resource[[:space:]]+"[^"]+"[[:space:]]+"[^"]+"' "$FILE_PATH" | awk '{gsub(/"/, "", $2); gsub(/"/, "", $3); print $2"."$3}' || true)
BASES_MODULE=$(grep -E '^[[:space:]]*module[[:space:]]+"[^"]+"' "$FILE_PATH" | awk '{gsub(/"/, "", $2); print "module."$2}' || true)
ALL_BASES="$BASES_RESOURCE $BASES_MODULE"

if [ -z "$(echo "$ALL_BASES" | tr -d '[:space:]')" ]; then
    echo "${yellow}Nessuna risorsa o modulo trovati nel file $FILENAME.${normal}"
    exit 0
fi

echo "${blue}Risorse base identificate nel codice:${normal}"
for base in $ALL_BASES; do
    if [ -n "$base" ]; then echo "  - $base"; fi
done
echo "---------------------------------------------------------"

echo "${bold}2. Setup dell'ambiente...${normal}"
init_environment "$DIR_A" "$ENV_A"

echo "---------------------------------------------------------"
echo "${bold}3. Lettura dello stato corrente nella Cartella (Ambiente: $ENV_A)...${normal}"
cd "$DIR_A"
STATE_LIST=$(terraform state list)
cd "$START_DIR"

RESOURCES_TO_REMOVE=""
for base in $ALL_BASES; do
    if [ -n "$base" ]; then
        MATCHES=$(echo "$STATE_LIST" | grep -E "^${base}([\.\[]|$)" || true)
        for match in $MATCHES; do
            RESOURCES_TO_REMOVE="$RESOURCES_TO_REMOVE $match"
        done
    fi
done

if [ -z "$(echo "$RESOURCES_TO_REMOVE" | tr -d '[:space:]')" ]; then
    echo "${red}Nessuna delle risorse nel file è attualmente instanziata nello stato di $DIR_A per l'ambiente $ENV_A.${normal}"
    exit 1
fi

echo "${blue}Risorse esatte pronte per la rimozione:${normal}"
for res in $RESOURCES_TO_REMOVE; do
    if [ -n "$res" ]; then echo "  -> $res"; fi
done
echo "---------------------------------------------------------"

echo "${bold}4. Inizio Rimozione ($ENV_A)...${normal}"

cd "$DIR_A"
for RES in $RESOURCES_TO_REMOVE; do
    if [ -z "$RES" ]; then continue; fi
    echo "${bold}Elaborazione:${normal} $RES"

    echo "  [-] Esecuzione (terraform state rm)..."

    set +e # Disabilita uscita automatica per intercettare l'errore

    # Esegue la rimozione catturando l'output in caso di errore
    REMOVE_OUTPUT=$(terraform state rm "$RES" 2>&1)
    REMOVE_RESULT=$?

    set -e

    if [ $REMOVE_RESULT -eq 0 ]; then
        echo "  ${green}[OK] Risorsa rimossa con successo dallo stato!${normal}"
    else
        echo "  ${red}[!!!] ERRORE durante la rimozione.${normal}"
        echo "        ${red}Dettaglio dell'errore di Terraform:${normal}"

        # Stampa l'errore formattato mantenendo l'indentazione
        echo "$REMOVE_OUTPUT" | while IFS= read -r line; do echo "        ${red}> $line${normal}"; done
    fi
    echo "---------------------------------------------------------"
done
cd "$START_DIR"

echo "${green}${bold}>>> Rimozione dallo stato completata! Le risorse esistono ancora su Azure ma non sono più tracciate in $ENV_A.${normal}"
