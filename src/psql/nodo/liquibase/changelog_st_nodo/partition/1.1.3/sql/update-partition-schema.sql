-- Aggiunge le colonne 'mesi_retention' e 'tipo' se non esistono e rende nullable le colonne 'giorni_retention' e 'mesi_retention'
ALTER TABLE partition.storico_config
ADD COLUMN IF NOT EXISTS mesi_retention integer,
ADD COLUMN IF NOT EXISTS tipo character varying(50);

ALTER TABLE partition.storico_config
ALTER COLUMN giorni_retention DROP NOT NULL,
ALTER COLUMN mesi_retention DROP NOT NULL;

-- Mantiene solo un record per schema-tabella
DELETE FROM partition.storico_config t
USING (
    SELECT ctid,
           ROW_NUMBER() OVER (PARTITION BY nome_schema, nome_tabella ORDER BY ctid) AS rn
    FROM partition.storico_config
) sub
WHERE t.ctid = sub.ctid
  AND sub.rn > 1;

-- Aggiorna configurazioni di retention mensile per tutte le tabelle diverse da re.re
UPDATE partition.storico_config
SET
    giorni_retention = NULL,
    mesi_retention   = 2,
    tipo             = 'mese'
WHERE NOT (nome_schema = 're' AND nome_tabella = 're');

-- Aggiorna configurazione tipo per tabella re.re
UPDATE partition.storico_config
SET tipo = 'giorno'
WHERE nome_schema = 're' and nome_tabella = 're';

-- Rende l'attributo tipo non opzionale
ALTER TABLE partition.storico_config
ALTER COLUMN tipo SET NOT NULL;

-- Crea la tabella di configurazione per le partizioni mensili
CREATE TABLE IF NOT EXISTS partition.tab_part_monthly (
    tabella           character varying(100) NOT NULL,
    schema            character varying(100) NOT NULL,
    prefisso_nome_indice character varying(100),
    campi_indice      character varying(100)
);

-- Inserisce nella tabella di configurazione per le partizioni mensili tutte le tabelle diverse da re.re che non sono già presenti
INSERT INTO partition.tab_part_monthly (tabella, schema, prefisso_nome_indice, campi_indice)
SELECT t.tabella, t.schema, t.prefisso_nome_indice, t.campi_indice
FROM partition.tab_part t
WHERE t.schema <> 're'
  AND NOT EXISTS (
      SELECT 1
      FROM partition.tab_part_monthly m
      WHERE m.tabella = t.tabella
        AND m.schema = t.schema
        AND m.prefisso_nome_indice = t.prefisso_nome_indice
        AND m.campi_indice = t.campi_indice
  );

-- Rimuove dalla tabella tab_part tutte le tabelle diverse da re.re
DELETE FROM partition.tab_part
WHERE NOT (tabella = 're' AND schema = 're');