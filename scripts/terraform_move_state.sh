#!/usr/bin/env bash
# Esce immediatamente se un comando fallisce
set -e

##############################################################################
# Script per migrare una risorsa tra due stati Terraform separati (Cartelle)
##############################################################################

if [ "$#" -ne 4 ]; then
    echo "====================================================================="
    echo "Uso: $0 <CARTELLA_A> <CARTELLA_B> <RISORSA_VECCHIA> <RISORSA_NUOVA>"
    echo "====================================================================="
    echo "Esempio:"
    echo "  $0 ./vecchio-progetto ./nuovo-progetto module.apim.azurerm_api_management_product.this module.apim_new.azurerm_api_management_product.this"
    exit 1
fi

DIR_A="$1"
DIR_B="$2"
RES_OLD="$3"
RES_NEW="$4"

# Salva la directory corrente per poter tornare indietro facilmente
START_DIR=$(pwd)

echo ">>> Inizio migrazione per la risorsa: $RES_OLD"

# ---------------------------------------------------------
# FASE 1: Estrazione ID e Rimozione dalla Cartella A
# ---------------------------------------------------------
echo ">>> [Cartella A] Accesso a $DIR_A..."
cd "$DIR_A" || { echo "Impossibile accedere a $DIR_A"; exit 1; }

# Verifica che la risorsa esista nello stato attuale e recupera l'ID di Azure
# Usa 'terraform state show' e filtra la riga 'id = "..."'
echo ">>> [Cartella A] Recupero del Resource ID per $RES_OLD..."
RESOURCE_ID=$(terraform state show -no-color "$RES_OLD" 2>/dev/null | grep -E "^[[:space:]]*id[[:space:]]*=" | head -n 1 | awk -F'"' '{print $2}')

if [ -z "$RESOURCE_ID" ]; then
    echo "ERRORE: Impossibile trovare la risorsa '$RES_OLD' o il suo ID nello stato in $DIR_A."
    exit 1
fi

echo ">>> [Cartella A] Resource ID trovato: $RESOURCE_ID"

# Rimuovi la risorsa dallo stato
echo ">>> [Cartella A] Rimozione di $RES_OLD dallo stato (terraform state rm)..."
terraform state rm "$RES_OLD"
echo ">>> [Cartella A] Rimozione completata con successo."

# ---------------------------------------------------------
# FASE 2: Importazione nella Cartella B
# ---------------------------------------------------------
# Torna alla cartella di partenza e poi vai alla Cartella B
cd "$START_DIR"
echo ">>> [Cartella B] Accesso a $DIR_B..."
cd "$DIR_B" || { echo "Impossibile accedere a $DIR_B"; exit 1; }

# Importa la risorsa nel nuovo stato usando l'ID recuperato
echo ">>> [Cartella B] Importazione della risorsa come $RES_NEW (terraform import)..."
terraform import "$RES_NEW" "$RESOURCE_ID"
echo ">>> [Cartella B] Importazione completata con successo!"

echo ">>> Migrazione terminata per: $RES_OLD -> $RES_NEW"
echo "====================================================================="
