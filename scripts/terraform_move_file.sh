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
if [ "$#" -ne 5 ]; then
    echo "${bold}Migrazione Stato Terraform tra cartelle con ambienti asimmetrici${normal}"
    echo "====================================================================="
    echo "${yellow}Uso:${normal} $0 <ENV_A> <ENV_B> <CARTELLA_A> <CARTELLA_B> <NOME_FILE.tf>"
    echo "${yellow}Esempio:${normal} $0 dev dev-new ./vecchio-progetto ./nuovo-progetto donations.tf"
    echo "====================================================================="
    exit 1
fi

ENV_A="$1"
ENV_B="$2"
DIR_A="$3"
DIR_B="$4"
FILENAME="$5"
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

echo "${bold}2. Setup degli ambienti sulle due cartelle...${normal}"
init_environment "$DIR_A" "$ENV_A"
init_environment "$DIR_B" "$ENV_B"

echo "---------------------------------------------------------"
echo "${bold}3. Lettura dello stato corrente nella Cartella A (Ambiente: $ENV_A)...${normal}"
cd "$DIR_A"
STATE_LIST=$(terraform state list)
cd "$START_DIR"

RESOURCES_TO_MOVE=""
for base in $ALL_BASES; do
    if [ -n "$base" ]; then
        MATCHES=$(echo "$STATE_LIST" | grep -E "^${base}([\.\[]|$)" || true)
        for match in $MATCHES; do
            RESOURCES_TO_MOVE="$RESOURCES_TO_MOVE $match"
        done
    fi
done

if [ -z "$(echo "$RESOURCES_TO_MOVE" | tr -d '[:space:]')" ]; then
    echo "${red}Nessuna delle risorse nel file è attualmente instanziata nello stato di $DIR_A per l'ambiente $ENV_A.${normal}"
    exit 1
fi

echo "${blue}Risorse esatte pronte per la migrazione:${normal}"
for res in $RESOURCES_TO_MOVE; do
    if [ -n "$res" ]; then echo "  -> $res"; fi
done
echo "---------------------------------------------------------"

echo "${bold}4. Inizio Migrazione ($ENV_A -> $ENV_B)...${normal}"
for RES in $RESOURCES_TO_MOVE; do
    if [ -z "$RES" ]; then continue; fi
    echo "${bold}Elaborazione:${normal} $RES"

    # --- Estrazione ID dalla Cartella A ---
    cd "$DIR_A"
    RESOURCE_ID=$(terraform state show -no-color "$RES" 2>/dev/null | grep -E "^[[:space:]]*id[[:space:]]*=" | head -n 1 | awk -F'"' '{print $2}' || true)

    if [ -z "$RESOURCE_ID" ]; then
        echo "  ${red}[!] Impossibile trovare l'ID Azure in $ENV_A. Salto.${normal}"
        cd "$START_DIR"
        continue
    fi
    echo "  ${green}[+] ID Azure recuperato:${normal} $RESOURCE_ID"

    # --- Rimozione dalla Cartella A ---
    echo "  [-] Rimozione da Cartella A (terraform state rm)..."
    terraform state rm "$RES" > /dev/null

    # --- Importazione nella Cartella B ---
    cd "$START_DIR" && cd "$DIR_B"
    echo "  [+] Importazione in Cartella B (terraform import in ambiente $ENV_B)..."

    set +e # Disabilita uscita automatica per intercettare l'errore

    # Esegue l'import catturando l'output per poterlo stampare in caso di errore
    IMPORT_OUTPUT=$(terraform import -var-file="./env/$ENV_B/terraform.tfvars" "$RES" "$RESOURCE_ID" 2>&1)
    IMPORT_RESULT=$?

    set -e

    if [ $IMPORT_RESULT -eq 0 ]; then
        echo "  ${green}[OK] Risorsa migrata con successo da $ENV_A a $ENV_B!${normal}"
    else
        echo "  ${red}[!!!] ERRORE durante l'importazione in Cartella B.${normal}"

        # Stampa l'errore formattato mantenendo l'indentazione
        echo "$IMPORT_OUTPUT" | while IFS= read -r line; do echo "        ${red}> $line${normal}"; done

        echo ""
        echo "        Rimossa da A ma NON aggiunta a B."
        echo "        Importa manualmente con: terraform import -var-file='./env/$ENV_B/terraform.tfvars' '$RES' '$RESOURCE_ID'"
    fi
    cd "$START_DIR"
    echo "---------------------------------------------------------"
done

echo "${green}${bold}>>> Migrazione da ${ENV_A} a ${ENV_B} completata!${normal}"
