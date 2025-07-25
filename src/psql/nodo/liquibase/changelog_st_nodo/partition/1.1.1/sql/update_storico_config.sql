GRANT USAGE, UPDATE, SELECT ON SEQUENCE "partition".seq_log TO azureuser;


delete from partition.storico_config where nome_schema = 'wfesp';
delete from partition.storico_part where nome_schema = 'wfesp';
