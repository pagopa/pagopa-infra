CREATE SEQUENCE IF NOT EXISTS seq_log
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;

GRANT USAGE, UPDATE, SELECT ON SEQUENCE "partition".seq_log TO azureuser;
