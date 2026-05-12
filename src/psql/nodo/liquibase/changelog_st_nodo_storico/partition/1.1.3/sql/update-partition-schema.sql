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